class ScheduleWeek
  attr_accessor :days
  attr_accessor :dose_count

  def last_day
    @days.last.date
  end
end




