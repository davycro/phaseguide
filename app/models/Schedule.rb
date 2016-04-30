class Schedule
  attr_accessor :start_date
  attr_accessor :weeks
  attr_accessor :catchup_weeks

  def initialize(start_date)
    @start_date = start_date
    @weeks = []
    @catchup_weeks = []

    # first 2 weeks
    2.times do
      @weeks << SevenDoseWeek.new(self.last_date+1.day)
    end

    # remaining 6 weeks are MWF doses
    6.times do
      @weeks << ThreeDoseWeek.new(self.last_date+1.day)
    end

    # add option for 4 weeks of catchup doses
    4.times do |i|
      @catchup_weeks << CatchupWeek.new(self.last_date+1.day+(i*7).days)
    end

    # update dose number for medication days
    @dose_number = 1
    days.each do |day|
      if day.class==MedicationDay
        day.dose_number = @dose_number
        @dose_number += 1
      end
    end

    # update dose number for catchup days
    dn = 1
    catchup_days.each do |day|
      if day.class==CatchupDay
        day.dose_number = dn
        dn += 1
      end
    end
  end

  def last_date
    if weeks.blank?
      return @start_date-1.day
    else
      return weeks.last.days.last.date
    end
  end

  def first_date
    if weeks.blank?
      return @start_date
    else
      return weeks.first.days.first.date
    end
  end

  def medication_days
    days.select { |d| d.class==MedicationDay }
  end

  def days
    weeks.map { |w| w.days }.flatten
  end

  def catchup_days
    catchup_weeks.map { |w| w.days }.flatten
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