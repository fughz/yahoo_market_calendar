# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yahoo_market_calendar/version'

Gem::Specification.new do |spec|
  spec.name          = "yahoo_market_calendar"
  spec.version       = YahooMarketCalendar::VERSION
  spec.authors       = ["fughz"]
  spec.email         = ["fughz.h@gmail.com"]

  spec.summary       = "simple client of Yahoo! Finance Market Clendar(http://info.finance.yahoo.co.jp/fx/marketcalendar/)"
  spec.homepage      = "https://github.com/fughz/yahoo_market_calendar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "nokogiri"
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
