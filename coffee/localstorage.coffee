( ->

  localStorageService = ($rootScope, $window) ->

    @loadMode = () ->
      if $window.localStorage
        _mode = $window.localStorage.getItem('quivel-mode')
        @sendToAllTabs({"message": "change_mode", "mode": _mode})
        return _mode

    @saveMode = (mode) ->
      if $window.localStorage
        $window.localStorage.setItem('quivel-mode', mode)
        @sendToAllTabs({"message": "change_mode", "mode": mode})
        return

    @sendToAllTabs = (msg) ->
      chrome.tabs.query({}, (tabs) ->
        for tab in tabs
          chrome.tabs.sendMessage(tab.id, msg)
      )

    @loadCurrency = () ->
      if $window.localStorage
        return $window.localStorage.getItem('quivel-currency')

    @saveCurrency = () ->
      if $window.localStorage
        $window.localStorage.setItem('quivel-currency', $rootScope.quivel.selectedCurrency)
        return

    return

  localStorageService
    .$inject = ['$rootScope', '$window']

  angular.module('quivel-storage', [])
    .service 'localStorageService', localStorageService

)()
