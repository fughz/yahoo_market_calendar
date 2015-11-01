# YahooMarketCalendar

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/yahoo_market_calendar`. To experiment with that code, run `bin/console` for an interactive prompt.

## Build Status
[![Circle CI](https://circleci.com/gh/fughz/yahoo_market_calendar.svg?style=svg)](https://circleci.com/gh/fughz/yahoo_market_calendar)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'yahoo_market_calendar'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yahoo_market_calendar

## Usage

A simple example program:

```ruby:example.rb
#!/usr/bin/env ruby
require 'date'
require 'yahoo_market_calendar'

client = YahooMarketCalendar::Client.new
day_events = client.get_market_events(date: Date.new(2015, 10, 30),
                                      country_code: YahooMarketCalendar::CountryCode::ALL,
                                      priority: YahooMarketCalendar::Priority::ALL)

day_events.each do |event|
  puts "time: " + event.time + " name: " +  event.name
  puts "  last: " + event.last_data +
       " expectation: " + event.expectation_data +
       " result: " + event.result_data
  puts "  priority: " + event.priority
  puts "  country_code: " + event.country_code
end
```

Produces output as:

```
...

time: 06:45 name: 7-9月期 四半期失業率
  last: 5.9％ expectation: 6.0％ result:
  priority: 2
  country_code: NZD
time: 08:50 name: 10月 マネタリーベース [前年同月比]
  last: 35.1％ expectation:  result:
  priority: 1
  country_code: JPY
time: 09:30 name: 9月 小売売上高 [前月比]
  last: 0.4％ expectation: 0.4％ result:
  priority: 2
  country_code: AUD
time: 09:30 name: 9月 貿易収支
  last: -30.95億豪ドル expectation: -29.00億豪ドル result:
  priority: 1
  country_code: AUD
time: 10:45 name: 10月 Ｃａｉｘｉｎサービス部門購買担当者景気指数（ＰＭＩ）
  last: 50.5 expectation:  result:
  priority: 2
  country_code: CNY
time: 14:00 name: 10月 消費者態度指数・一般世帯
  last: 40.6 expectation: 41.0 result:
  priority: 1
  country_code: JPY
  
  ...
  ```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/yahoo_market_calendar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
