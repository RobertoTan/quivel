( ->

  quivelPopup = ($rootScope, $window, $timeout, sabreService) ->
    template: "<div id='quivel--popup'><div class='quivel--hotel-item' ng-show='$root.quivel.hotels' ng-repeat='hotel in $root.quivel.hotels'><div class='img-container'><img ng-src='{{hotel.HotelImageInfo.ImageItem.Image.Url}}'/></div><div class='quivel--hotel-info'><div class='quivel--hotel-name' ng-bind='hotel.HotelInfo.HotelName'></div><div class='quivel--hotel-price'><span class='label'>Price: </span><span ng-bind='hotel.HotelRateInfo.RatePlan.Rate.CurrencyCode'></span> <span ng-bind='hotel.HotelRateInfo.RatePlan.Rate.AmountBeforeTax'></span></div><div class='quivel--book-now'>Book Now</div></div></div><div class='quivel--location-item' ng-show='!$root.quivel.hotels' ng-repeat='img in $root.quivel.images' ng-click='$root.quivel.getHotel(img.location)' ><img ng-src='{{img.src}}'/><div class='label' ng-bind='img.location'></div></div></div>"
    link: (scope, element, attrs) ->
      $rootScope.quivel = {}
      $rootScope.quivel.name = "quivel popup"
      jElement = $('#quivel--popup')

      $rootScope.quivel.getHotel = (location) ->
        console.log "$rootScope.quivel.getHotel",  location
        sabreService.getHotelRate(location).then((data)->
          # console.log(data)
          return if !data.GetHotelAvailRS.HotelAvailInfos
          $rootScope.quivel.hotels = data.GetHotelAvailRS.HotelAvailInfos.HotelAvailInfo
          # console.log $rootScope.quivel.hotels
          $timeout( ->
            $rootScope.$apply()
          , 10)
        )

      $rootScope.$on 'display-popup', (e, obj) ->
        $rootScope.quivel.name = "quivel popup is shown"
        $rootScope.quivel.images = sabreService.images()
        # console.log $rootScope.quivel.images
        $rootScope.$apply()
        jElement.show()
        return

      $rootScope.$on 'close-popup', (e) ->
        jElement.hide()
        return

  quivelPopup
    .$inject = ['$rootScope', '$window', '$timeout', 'sabreService']

  angular.module('quivel')
    .directive 'quivelPopup', quivelPopup

)()
