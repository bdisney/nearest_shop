getCookie = (name) ->
  value = '; ' + document.cookie
  parts = value.split('; ' + name + '=')
  if parts.length == 2
    parts.pop().split(';').shift()

rounded_value = (value) ->
  Math.round(value * 10000)/10000

getUserPosition = ->
  return if getCookie('selected_shop')
  if navigator.geolocation
    navigator.geolocation.getCurrentPosition (position) ->
      coords    = position.coords
      latitude  = rounded_value(getCookie('latitude'))
      longitude = rounded_value(getCookie('longitude'))

      return if latitude == rounded_value(coords.latitude) && longitude == rounded_value(coords.longitude)

      $.ajax
        type: 'GET'
        url:  '/'
        data: {position: position.coords }
      document.cookie = "latitude="  + escape(coords.latitude)
      document.cookie = "longitude=" + escape(coords.longitude)

selectShop = ->
  $('.js-shops-select').on 'change', ->
    shop_id = $(this).val()
    $.ajax
      type: 'GET'
      url:  '/'
      data: { selected_shop: { shop_id: shop_id} }
      document.cookie = "selected_shop=" + escape(shop_id)

$(document).on 'ready ajaxSuccess', ->
  return if $('.js-store').length == 0
  getUserPosition()
  selectShop()
