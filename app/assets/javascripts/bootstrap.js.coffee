jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()

$(document).on 'turbolinks:load', ->
  $(".alert").fadeOut(3500)
