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

  removeMissedDose: ->
    day = $('.CatchupDay.active:last');
    day.removeClass 'active'
    day.addClass 'inactive'
    $('.CatchupDay.active:last ~ .day').addClass('inactive').removeClass('active')
    if day.siblings('.active').length==0
      day.parent().removeClass('active')

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


ready = ->
  @scheduleController = new ScheduleController()
  @medicationDayController = new MedicationDayController(@scheduleController)


$(document).ready(ready)
$(document).on('page:load', ready)


