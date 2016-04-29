class PagesController < ApplicationController
  def initial_phase
    if params[:start_date].blank?
      @start_date = Date.today
    else
      @start_date = Date.parse params[:start_date]
    end
    @schedule = Schedule.new @start_date
  end
end
