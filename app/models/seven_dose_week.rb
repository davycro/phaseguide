class SevenDoseWeek < ScheduleWeek
  def initialize(start_date)
    @dose_count = 7
    @days = []

    current_date = start_date
    7.times do
      @days << ScheduleDate.new(current_date, 1)
      current_date += 1.day
    end
  end
end