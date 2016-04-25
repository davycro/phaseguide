class PagesController < ApplicationController
  def index
    @schedule = Schedule.new(Date.today)
  end
end
