class App.MainController extends Mozart.Controller

  init: =>
    @bind 'change:red', @doColour
    @bind 'change:green', @doColour
    @bind 'change:blue', @doColour

    @bind 'change:colour', @doRGB

  doColour: =>
    return if @updating
    @updating = true
    @set 'colour', parseInt(@red) << 16 | parseInt(@green) << 8 | parseInt(@blue)
    @updating = false

  doRGB: =>
    return if @updating
    @updating = true

    @set 'red', (@colour >> 16) & 0xFF
    @set 'green', (@colour >> 8) & 0xFF
    @set 'blue', @colour & 0xFF

    @updating = false