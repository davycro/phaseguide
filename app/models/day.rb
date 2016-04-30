class Day

  attr_accessor :date
  attr_accessor :dose_count
  attr_accessor :dose_number

  def initialize(date)
    @date = date
    @dose_count = 0
  end

  def dose_contents
    "Isoniazid Rifampin Pyridoxamine Ethambutol"
  end

  def dose_status
    if @date <= Date.today
      return "Completed"
    else
      return "Pending"
    end
  end
end