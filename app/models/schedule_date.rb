class ScheduleDate

  attr_accessor :date
  attr_accessor :dose_count

  def initialize(date, dose_count)
    @date = date
    @dose_count = dose_count
  end
end