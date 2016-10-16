( ->
  angular.module("quivel-options", [
    'ngSanitize',
    'quivel-storage'
  ])

  .run [

    "$rootScope", 'localStorageService'
    ($rootScope, localStorageService) ->

      $rootScope.globalState = {
        appInitialized: false
      }

      $rootScope.globalState.appInitialized = true

      $rootScope.quivel = {}
      $rootScope.options = {}

      $rootScope.globalState.currencyList = [
        {label: "$ SGD", value: "SGD"},
        {label: "$ USD", value: "USD"},
      ]

      defaultCurrency = "SGD"

      $rootScope.quivel.selectedCurrency = localStorageService.loadCurrency()
      console.log $rootScope.quivel.selectedCurrency
      $rootScope.quivel.selectedCurrency = defaultCurrency if !$rootScope.quivel.selectedCurrency

      $rootScope.quivel.saveCurrency = () ->
        console.log $rootScope.quivel.selectedCurrency
        localStorageService.saveCurrency()

      return
  ]
)()
