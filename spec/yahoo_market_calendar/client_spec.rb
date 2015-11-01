require 'spec_helper'

describe YahooMarketCalendar::Client do
  describe '.get_market_events' do
    it 'get_market_events get only today event' do
      this_week_wednesday = Date.today - (Date.today.wday - 3)

      client = YahooMarketCalendar::Client.new
      day_events = client.get_market_events(date: this_week_wednesday,
                                            country_code: YahooMarketCalendar::CountryCode::ALL,
                                            priority: YahooMarketCalendar::Priority::ALL);

      expect(day_events.nil?).to eq false
      expect(day_events.date).to eq this_week_wednesday
      
      day_events.each do |event|
        expect(event.name.empty?).to eq false
        expect(event.priority.empty?).to eq false
        expect(event.country_code.empty?).to eq false
      end
    end

    it 'get_market_events invalid day' do
      invalid_day = Date.new(1970, 1, 1)
      
      client = YahooMarketCalendar::Client.new
      day_events = client.get_market_events(date: invalid_day,
                                            country_code: YahooMarketCalendar::CountryCode::ALL,
                                            priority: YahooMarketCalendar::Priority::ALL);
      expect(day_events.nil?).to eq true
    end
    
  end
end
