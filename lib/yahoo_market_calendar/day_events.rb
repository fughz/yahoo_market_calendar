require 'date'

class YahooMarketCalendar::DayEvents

  attr_accessor :date, :events
  
  def initialize
    @date = Date.new
    @events = []
  end
  
end
