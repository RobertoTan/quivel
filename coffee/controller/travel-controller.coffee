( ->

  travelController = ($scope, $rootScope, $window) ->
    console.log "$scope.quivel.displayPopup"
    console.log $scope.quivel.displayPopup
    $scope.name = "travelController"
    $scope.$on 'display-popup', (obj) ->
      $scope.quivel.displayPopup = true
      $scope.displayPopup = true
      console.log obj
    return

  travelController
    .$inject = ['$scope', '$rootScope', '$window']

  angular.module('quivel')
    .controller 'travelController', travelController

)()
