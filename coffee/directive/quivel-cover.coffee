( ->

  quivelCover = ($rootScope, $window) ->
    template: "<div id='quivel--cover' ng-click='$root.quivel.closePopup()'></div>"
    link: (scope, element, attrs) ->
      jElement = $('#quivel--cover')

      $rootScope.$on 'display-popup', (e, obj) ->
        jElement.show()
        return

      $rootScope.quivel.closePopup = () ->
        jElement.hide()
        $rootScope.$broadcast('close-popup')
        return

  quivelCover
    .$inject = ['$rootScope', '$window']

  angular.module('quivel')
    .directive 'quivelCover', quivelCover

)()
