class PagesController < ApplicationController
  def index
    @schedule = Schedule.new(Date.today)
  end

  def schedule
    if params[:date].blank?
      d = Date.today
    else
      d = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, params[:date][:day].to_i)
    end
    @schedule = Schedule.new d
  end
end
