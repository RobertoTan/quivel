( ->
  angular.module("quivel", [
    'ngSanitize'
  ])

  .run [

    "$rootScope", '$timeout', '$window', 'generatePageService', 'chromeService', 'sabreService', 'QUIVEL_MODE'
    ($rootScope, $timeout, $window, generatePageService, chromeService, sabreService, QUIVEL_MODE) ->

      $rootScope.globalState = {
        appInitialized: false
        mode: QUIVEL_MODE
        loading: true
      }

      $rootScope.quivel = {
        displayPopup: false
      }

      $rootScope.quivel.selectedCurrency = $window.localStorage.getItem('quivel-currency') || 'SGD'
      console.log "$rootScope.quivel.selectedCurrency", $rootScope.quivel.selectedCurrency

      $rootScope.globalState.appInitialized = true

      chromeService.init()

      generatePageService.init()

      sabreService.checkImageText()

      return
  ]

  _initialized = false
  chrome.runtime.onMessage.addListener(
    (request, sender, sendResponse) ->
      if _initialized == false
        _initialized = true
        app = angular.module("quivel")
        app.constant('QUIVEL_MODE', request.mode)
        angular.element(document).ready ->
          quivelRoot = $('<div id=\'quivel--root\' ng-app=\'quivel\'><div id=\'quivel--loading-popup\' ng-show=\'$root.globalState.loading\'><div class=\'inner\'><img src=\'https://media.giphy.com/media/3oEjI6SIIHBdRxXI40/giphy.gif\'/></div></div><quivel-popup></quivel-popup><quivel-cover></quivel-cover></div>')
          $('body').append quivelRoot
          angular.bootstrap quivelRoot, [ 'quivel' ]
          return
  )
)()
