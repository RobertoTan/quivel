( ->

  sabreService = ($rootScope, $timeout, $window, $http, $q) ->

    @getHotelRate = (location) ->
      $rootScope.globalState.loading = true
      $timeout(->
        $rootScope.$apply()
      , 1)
      $rootScope.quivel.selectedCurrency = $window.localStorage.getItem('quivel-currency') || 'SGD'
      console.log "$rootScope.quivel.selectedCurrency", $rootScope.quivel.selectedCurrency
      data = {
        "currency": $rootScope.quivel.selectedCurrency,
        "checkin": $rootScope.quivel.checkIn,
        "checkout": $rootScope.quivel.checkOut,
        "poi": location
        "country": "FR"
      }
      req = {
        method: 'POST',
        url: 'http://localhost:1337/hotel',
        headers: {
          'Content-Type': 'application/json'
        },
        data: data
      }
      defer = $q.defer()
      $http(req).then((res)->
        $rootScope.globalState.loading = false
        $timeout(->
          $rootScope.$apply()
        , 1)
        defer.resolve res.data
      )
      return defer.promise

    _images = {}
    @images = () ->
      return _images

    _done = false
    _displaying = null
    @checkDone = () ->
      console.log "checkDone", _checking
      return if _checking > 0
      return if _done
      _done = true
      return if _displaying
      _displaying = $timeout( ->
        $rootScope.$broadcast('display-popup')
      , 10)
      $rootScope.globalState.loading = false
      $timeout(->
        $rootScope.$apply()
      , 1)

    @checkImageAltTxt = (alt) ->
      data = {
        "alt": alt
      }
      req = {
        method: 'POST',
        url: 'http://localhost:1337/imgtext',
        headers: {
          'Content-Type': 'application/json'
        },
        data: data
      }
      console.log "checkImageAltTxt", alt
      $http(req).then((res)=>
        # console.log res.data
        hasLocation = false
        for entity in res.data.entities
          if entity.salience < 0.15 && entity.type == "LOCATION" && entity.name != "Sunset"
            _images[alt].location = entity.name
            hasLocation = true
        delete _images[alt] if !hasLocation
        _checking -= 1
        @checkDone()
      )
      return

    _checking = 0

    @checkImageText = () ->
      _checking = 0
      _done = false
      _displaying = null
      _images = {}
      $rootScope.globalState.loading = true
      $timeout(->
        $rootScope.$apply()
      , 1)
      console.log "checkImageText"
      $('img').each( ->
        alt = $(this).attr('alt')
        if alt && alt.length > 25 && !_images[alt]
          _images[alt] = {
            src: $(this).attr('src')
          }
      )
      _limit = 0
      for alt, url of _images
        _limit += 1
        if _limit < 8
          _checking += 1
          @checkImageAltTxt(alt)
        else
          delete _images[alt]

    return



  sabreService
    .$inject = ['$rootScope', '$timeout', '$window', '$http', '$q']

  angular.module('quivel')
    .service 'sabreService', sabreService

)()
