# coding: utf-8
require 'date'
require 'chronic'
require 'open-uri'
require 'nokogiri'

class YahooMarketCalendar::Client

  API_URL = 'http://info.finance.yahoo.co.jp/fx/marketcalendar/'

  def get_market_events(start_date: Date.today, **options)
    end_date     = options[:end_date]     || start_date
    country_code = options[:country_code] || YahooMarketCalendar::CountryCode::ALL
    priority     = options[:priority]     || YahooMarketCalendar::Priority::ALL

    if end_date < start_date
    end
    
    charset = nil
    html = open(create_api_url(start_date, country_code, priority)) do |f|
      charset = f.charset
      f.read # read html text
    end
    
    doc = Nokogiri::HTML.parse(html, nil, charset)

    day_events_array = []
    day_events = nil

    doc.xpath("//*[@id='main']/div[3]/table").each do |node|
      node.css('tr').each do |row|
        unless row.css('th.date').empty? then
          parsed_date = get_event_date(start_date.year, row.css('th.date').inner_text)
          if parsed_date < start_date or end_date < parsed_date
            next
          end
          day_events = YahooMarketCalendar::DayEvents.new
          day_events.date = parsed_date
          day_events_array << day_events
        else
          unless day_events.nil?
            event = YahooMarketCalendar::Event.new
            event.time = get_event_time(day_events.date, row.css('td.time').inner_text)
            event.name = row.css('td.event').inner_text
            event.priority = row.css('td.priority').css('span').attribute('class').value
            event.country_code = row.css('td.event').css('span').attribute('class').value
            event.last_data = row.css('td.last').inner_text
            event.expectation_data = row.css('td.expectation').inner_text
            event.result_data = row.css('td.result').inner_text
            day_events.events << event
          end
        end
      end
    end
    day_events_array
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

  def get_event_time(date, time_text)
    Chronic.parse(date.strftime("%Y-%m-%d") + time_text)
  end
end

