class Day

  attr_accessor :date
  attr_accessor :dose_count

  def initialize(date)
    @date = date
    @dose_count = 0
  end
end