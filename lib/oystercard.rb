require_relative 'journey'

class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_AMOUNT = 1
  DEFAULT_BALANCE = 0
  attr_reader :balance
  attr_reader :history
  attr_reader :new_journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @history = []
    @previous_journey_complete = nil
  end

  def top_up(amount)
    fail "balance exceeds £#{MAXIMUM_LIMIT}" if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(entry_station)
    fail "balance under £#{MINIMUM_AMOUNT}" if @balance < MINIMUM_AMOUNT
    @new_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    @new_journey.finish(exit_station)
    deduct_fare
    add_to_history
    @new_journey.exit_station = nil
    @new_journey.entry_station = nil
  end

  private

  def deduct_fare
    @balance -= @new_journey.fare
  end

  def add_to_history
    @history << {:entry_station => @new_journey.entry_station, :exit_station => @new_journey.exit_station}
  end

end
