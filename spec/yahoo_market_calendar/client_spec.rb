require 'spec_helper'

describe YahooMarketCalendar::Client do
  describe '.get_market_events' do
    it 'get_market_events get only today event' do
      client = YahooMarketCalendar::Client.new

      this_week_wednesday = Date.today - (Date.today.wday - 3)

      events = client.get_market_events(start_date: this_week_wednesday,
                                        end_date: this_week_wednesday,
                                        country_code: YahooMarketCalendar::CountryCode::ALL,
                                        priority: YahooMarketCalendar::Priority::ALL);

      expect(events.empty?).to eq false
      expect(events.size).to eq 1

      events.each do |day_events|
        expect(day_events.date).to eq this_week_wednesday
        day_events.events.each do |event|
          #expect(event.time.empty?).to eq false
          expect(event.name.empty?).to eq false
          expect(event.priority.empty?).to eq false
          expect(event.country_code.empty?).to eq false
        end
      end
    end
  end
end
