#!/usr/bin/env ruby
require 'date'
require 'yahoo_market_calendar'

client = YahooMarketCalendar::Client.new
day_events = client.get_market_events(date: Date.new(2015, 10, 30),
                                      country_code: YahooMarketCalendar::CountryCode::ALL,
                                      priority: YahooMarketCalendar::Priority::ALL)

day_events.each do |event|
  puts "time: " + (event.time.nil? ? "N/A" : event.time.strftime("%H:%M")) +
       " name: " +  event.name
  puts "  last: " + event.last_data +
       "expectation: " + event.expectation_data +
       "result: " + event.result_data
  puts "  priority: " + event.priority
  puts "  country_code: " + event.country_code
end


