class CatchupWeek < Week

  def initialize(start_date)
    @dose_count = 0
    @days = []

    current_date = start_date
    7.times do
      if current_date.monday? or current_date.wednesday? or current_date.friday?
        @days << CatchupDay.new(current_date)
      else
        @days << HoldDay.new(current_date)
      end
      current_date += 1.day
    end
  end
end