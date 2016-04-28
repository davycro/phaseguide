# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $('.day_col').mouseover (e) ->
    $(e.currentTarget).addClass('hover_col')

  $('.day_col').mouseout (e) ->
    $(e.currentTarget).removeClass('hover_col')


$(document).ready(ready)
$(document).on('page:load', ready)