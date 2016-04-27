class Schedule
  attr_accessor :start_date
  attr_accessor :week1
  attr_accessor :week2
  attr_accessor :week3
  attr_accessor :week4
  attr_accessor :week5
  attr_accessor :week6
  attr_accessor :week7
  attr_accessor :week8

  def initialize(start_date)
    @start_date = start_date
    @week1 = ScheduleWeek.new(@start_date, 7)
    @week2 = ScheduleWeek.new(@week1.last_day+1.day, 7)
    @week3 = ScheduleWeek.new(@week2.last_day+1.day, 3)
    @week4 = ScheduleWeek.new(@week3.last_day+1.day, 3)
    @week5 = ScheduleWeek.new(@week4.last_day+1.day, 3)
    @week6 = ScheduleWeek.new(@week5.last_day+1.day, 3)
    @week7 = ScheduleWeek.new(@week6.last_day+1.day, 3)
    @week8 = ScheduleWeek.new(@week7.last_day+1.day, 3)
  end

  def weeks
    [@week1, @week2, @week3, @week4, @week5, @week6, @week7, @week8]
  end

  def days
    weeks.map { |w| w.days }.flatten
  end

  def dose_count
    weeks.map { |w| w.dose_count }.sum
  end

  def dose_count_today
    dc = 0
    stop_date = Date.today
    days.each do |day|
      dc += day.dose_count
      if day.date > stop_date
        return dc
      end
    end
    return dc
  end

  def day_count_today
    dc = 0
    stop_date = Date.today
    days.each do |day|
      dc += 1
      if day.date > stop_date
        return dc
      end
    end
    return dc
  end

end