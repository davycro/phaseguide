class MedicationDay < Day
  def initialize(start_date)
    super(start_date)
    @dose_count = 1
  end
end