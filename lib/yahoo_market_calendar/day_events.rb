require 'date'

class YahooMarketCalendar::DayEvents
  include Enumerable
  
  attr_accessor :date, :events
  
  def initialize
    @date = Date.new
    @events = []
  end

  def <<(event)
    @events << event
  end

  def each
    @events.each do |event|
      yield event
    end
  end
  
end
