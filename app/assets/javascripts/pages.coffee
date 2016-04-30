# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class ScheduleController extends Spine.Module
  @extend(Spine.Events)
  
  constructor: ->
    @el = $('.Schedule')
    @missedDoseCount = 0      

  addMissedDose: (dayEl) ->
    # find first available catchup day
    day = $('.CatchupDay.inactive').first();
    sibs = $('.CatchupDay.inactive:first ~ .day');
    # find parent week
    week = $(day).parent();
    $(week).addClass('active');
    # show all days in previous week
    $(week).prev('.CatchupWeek').children(".day").removeClass('inactive')
    # show all days in week
    $(week).children(".day").addClass('active').removeClass('inactive');
    # hide all days after catchupday
    $(sibs).removeClass('active').addClass('inactive')
    @missedDoseCount += 1
    @updateStopDateText(); # must come after increment

  removeMissedDose: ->
    day = $('.CatchupDay.active:last');
    day.removeClass 'active'
    day.addClass 'inactive'
    $('.CatchupDay.active:last ~ .day').addClass('inactive').removeClass('active')
    if day.siblings('.active').length==0
      day.parent().removeClass('active')
    @missedDoseCount -= 1
    @updateStopDateText();

  updateStopDateText: ->
    # get last date
    if @missedDoseCount >= 1
      d = $('.CatchupDay.active:last').attr('data-date');
    else
      d = $('.MedicationDay:last').attr('data-date');
    $('.stop_date_text').html("#{d}")

class MedicationDayController extends Spine.Module
  @extend(Spine.Events)

  constructor: (@scheduleController) ->
    @el = $('.MedicationDay, .CatchupDay')

    @el.mouseover ->
      $(this).addClass 'hover'
    @el.mouseout ->
      $(this).removeClass 'hover'

    @el.click (e) =>
      t = $(e.currentTarget);
      unless t.hasClass('missed')
        if $('.CatchupDay.inactive').length==0
          alert "Cannot miss anymore days, please restart phase"
          return

        $(e.currentTarget).addClass 'missed'
        @scheduleController.addMissedDose();
      else
        t.removeClass 'missed'
        @scheduleController.removeMissedDose();


class StartDateSelector

  constructor: ->
    @el = $('.StartDateSelector')
    $(@el, 'select').on 'change', (e) =>
      @update()

  update: ->
    window.location = "?start_date=#{@getDateString()}";

  getDateString: ->
    y = $("select#date_year option:selected").val()
    m = $("#date_month option:selected").val()
    d = $("#date_day option:selected").val()
    str = "#{y}-#{m}-#{d}"
    console.log str
    str


ready = ->
  @scheduleController = new ScheduleController()
  @medicationDayController = new MedicationDayController(@scheduleController)
  @startDateSelector = new StartDateSelector()


$(document).ready(ready)
$(document).on('page:load', ready)


