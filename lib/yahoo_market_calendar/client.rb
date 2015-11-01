# coding: utf-8
require 'date'
require 'open-uri'
require 'nokogiri'

class YahooMarketCalendar::Client

  API_URL = 'http://info.finance.yahoo.co.jp/fx/marketcalendar/'

  def get_market_events(date: Date.today, **options)
    country_code = options[:country_code] || YahooMarketCalendar::CountryCode::ALL
    priority     = options[:priority]     || YahooMarketCalendar::Priority::ALL

    charset = nil
    html = open(create_api_url(date, country_code, priority)) do |f|
      charset = f.charset
      f.read # read html text
    end
    
    doc = Nokogiri::HTML.parse(html, nil, charset)

    day_events = nil

    doc.xpath("//*[@id='main']/div[3]/table").each do |node|
      node.css('tr').each do |row|
        unless row.css('th.date').empty? then
          parsed_date = get_event_date(date.year, row.css('th.date').inner_text)
          if parsed_date === date
            day_events = YahooMarketCalendar::DayEvents.new
            day_events.date = parsed_date
          elsif not day_events.nil?
            # got all specified day event
            return day_events
          end
        else
          unless day_events.nil?
            event = YahooMarketCalendar::Event.new
            event.time = row.css('td.time').inner_text
            event.name = row.css('td.event').inner_text
            event.priority = get_priority(row.css('td.priority').css('span').attribute('class').value)
            event.country_code = get_country_code(row.css('td.event').css('span').attribute('class').value)
            event.last_data = row.css('td.last').inner_text
            event.expectation_data = row.css('td.expectation').inner_text
            event.result_data = row.css('td.result').inner_text
            day_events << event
          end
        end
      end
    end
    return day_events
  end
        
  private

  def create_api_url(date, country_code, priority)
    API_URL + "?d=" + date.strftime("%Y%m%d") + "&c=" + country_code + "&i=" + priority
  end
  
  def get_event_date(year, date_text)
    /(\d+)\/(\d+)/ =~ date_text
    month = $1.to_i
    day = $2.to_i
    Date.new(year, month, day)
  end

  def get_priority(priority_class_text)
    /icoRating(\d+)/ =~ priority_class_text
    case $1.to_i
    when 1 then
      YahooMarketCalendar::Priority::LOW
    when 2 then
      YahooMarketCalendar::Priority::MIDDLE
    when 3 then
      YahooMarketCalendar::Priority::HIGH
    else
      YahooMarketCalendar::Priority::UNKNOWN
    end
  end

  def get_country_code(country_class_text)
    /icon\d+ ico([a-zA-Z]+)\d+/ =~ country_class_text
    case $1
    when "Jpn" then
      YahooMarketCalendar::CountryCode::JP
    when "Usa" then
      YahooMarketCalendar::CountryCode::US
    when "Eu" then
      YahooMarketCalendar::CountryCode::EUR
    when "Ger" then
      YahooMarketCalendar::CountryCode::DE
    when "Fra" then
      YahooMarketCalendar::CountryCode::FR
    when "Gbr" then
      YahooMarketCalendar::CountryCode::GB
    when "Aus" then
      YahooMarketCalendar::CountryCode::AU
    when "Nzl" then
      YahooMarketCalendar::CountryCode::NZ
    when "Sui" then
      YahooMarketCalendar::CountryCode::CH
    when "Can" then
      YahooMarketCalendar::CountryCode::CA
    when "Rsa" then
      YahooMarketCalendar::CountryCode::ZA
    when "Sin" then
      YahooMarketCalendar::CountryCode::SG
    when "Hkg" then
      YahooMarketCalendar::CountryCode::HK
    when "Cnh" then
      YahooMarketCalendar::CountryCode::CN
    else
      YahooMarketCalendar::CountryCode::UNKNOWN
    end
  end
end

