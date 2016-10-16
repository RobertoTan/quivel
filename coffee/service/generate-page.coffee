( ->

  generatePageService = ($rootScope, $window, $timeout) ->

    _mode = null
    _travelPopup = null
    _popupCover = null
    _scope = null

    @editMode = () ->
      console.log "edit mode"
      $('body').removeClass("quivel--live-mode")
      $('body').addClass("quivel--edit-mode")
      $timeout( () ->
        targets = ".quivel--edit-mode img"

        $(targets).click( (e) ->
          console.log e
          e.stopPropagation()
          e.preventDefault()
        )

        $(targets).hover( (e) ->
          $(this).addClass('hovered')
          e.stopPropagation()
          e.preventDefault()
        , (e) ->
          $(this).removeClass('hovered')
        )

      , 10)
      return

    @liveMode = () ->
      console.log "live mode"
      $(".quivel--edit-mode img").unbind('click')
      $(".quivel--edit-mode div").unbind('click')
      $(".quivel--edit-mode span").unbind('click')
      $('body').removeClass("quivel--edit-mode")
      $('body').addClass("quivel--live-mode")
      $timeout( () ->
        $(".quivel--live-mode img").click((e) ->
          e.stopPropagation()
          e.preventDefault()
          $rootScope.$broadcast('display-popup', e.currentTarget)
        )
      , 10)

    @init = () ->
      $rootScope.$on 'quivel-mode-changed', () =>
        console.log 'quivel-mode-changed', $rootScope.globalState.mode
        return if _mode == $rootScope.globalState.mode
        _mode = $rootScope.globalState.mode
        @liveMode() if _mode == 'live'
        @editMode() if _mode == 'edit'
      return

    return

  generatePageService
    .$inject = ['$rootScope', '$window', '$timeout']

  angular.module('quivel')
    .service 'generatePageService', generatePageService

)()
