class PagesController < ApplicationController
  def index
    @schedule = Schedule.new(Date.today)
  end

  def schedule
    d = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
    @schedule = Schedule.new d
  end
end
