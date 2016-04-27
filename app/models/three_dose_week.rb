class ThreeDoseWeek < ScheduleWeek
  def initialize(start_date)
    @dose_count = 3
    @days = []

    current_date = start_date
    7.times do
      dc = 0
      if current_date.monday? or current_date.wednesday? or current_date.friday?
        dc += 1
      end
      @days << ScheduleDate.new(current_date, dc)
      current_date += 1.day
    end
  end
end