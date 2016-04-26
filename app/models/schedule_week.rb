class ScheduleWeek

  attr_accessor :days
  attr_accessor :dose_count


  def initialize(start_date, dose_count)
    @dose_count = dose_count
    @days = []

    # init the days array
    current_date = start_date
    7.times do
      @days << ScheduleDate.new(current_date, 0)
      current_date += 1.day
    end

    # distribute doses into array equally
    n = dose_count
    filling_order = [0,2,4,6,1,5,3]
    (1..n).to_a.in_groups_of(7).each do |group|
      group.each_with_index do |member, index|
        if member.present?
          i = filling_order[index]
          @days[i].dose_count += 1
        end
      end
    end
  end

  def last_day
    @days.last.date
  end

  def dose_array(num_doses)
    case num_doses
    when 1
      return [true, false, false, false, false, false, false]
    when 2
      return [true, false, false, true, false, false, false]
    when 3
      return [true, false, true, false, true, false, false]
    when 4
      return [true, false, true, false, true, false, true]
    when 5
      return [true, true, true, false, true, false, true]
    when 6
      return [true, true, true, true, true, true, false]
    when 7
      return [true, true, true, true, true, true, true]
    end
  end

end