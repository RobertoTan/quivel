( ->
  angular.module("quivel-browser", [
    'ngSanitize',
    'quivel-storage'
  ])

  .run [

    "$rootScope", 'localStorageService'
    ($rootScope, localStorageService) ->

      $rootScope.globalState = {
        appInitialized: false
        mode: 'live'
      }

      $rootScope.globalState.appInitialized = true

      $rootScope.globalState.mode = localStorageService.loadMode() || 'live'

      $rootScope.quivel = {}

      $rootScope.quivel.setEditMode = () ->
        $rootScope.globalState.mode = 'edit'
        localStorageService.saveMode('edit')

      $rootScope.quivel.setLiveMode = () ->
        $rootScope.globalState.mode = 'live'
        localStorageService.saveMode('live')

      return
  ]
)()
