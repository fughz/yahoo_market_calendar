

class YahooMarketCalendar::Event
  attr_accessor :time, :name, :priority, :country_code, :last_data, :expectation_data, :result_data

  def initialize
    @time = String.new
    @name = String.new
    @priority = YahooMarketCalendar::Priority::ALL
    @country_code = YahooMarketCalendar::CountryCode::ALL
    @last_data = String.new
    @expect_data = String.new
    @result_data = String.new
  end

end
