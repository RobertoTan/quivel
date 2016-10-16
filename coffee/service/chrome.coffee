( ->

  chromeService = ($rootScope, $window, sabreService) ->

    @init = () ->
      chrome.runtime.onMessage.addListener(
        (request, sender, sendResponse) ->
          # if request.message == "change_mode" && $rootScope.globalState.mode != request.mode
          #   $rootScope.globalState.mode = request.mode
          #   $rootScope.$broadcast('quivel-mode-changed')
          #   console.log "$rootScope.globalState.mode"
          #   console.log $rootScope.globalState.mode
          #   return
          sabreService.checkImageText()
      )
      return
    return

  chromeService
    .$inject = ['$rootScope', '$window', 'sabreService']

  angular.module('quivel')
    .service 'chromeService', chromeService

)()
