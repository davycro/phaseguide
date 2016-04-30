class SevenDoseCatchupWeek < Week
  def initialize(start_date)
    @dose_count = 7
    @days = []

    current_date = start_date
    7.times do
      @days << CatchupDay.new(current_date)
      current_date += 1.day
    end
  end
end