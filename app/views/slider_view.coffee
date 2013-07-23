class App.SliderView extends Mozart.View
  skipTemplate: true
  tag: 'div'

  init: ->
    super
    @step ?= 1
    @min ?= 0
    @max ?= 100
    @value ?= 0

    @bind 'change:step', @redraw
    @bind 'change:min', @redraw
    @bind 'change:max', @redraw

    @bind 'change:value', @changeValue

  afterRender: =>
    @element.slider
      value: @value
      min: @min
      max: @max
      step: @step
      slide: (event, ui) =>
        @set('value',ui.value)

  changeValue: =>
    @element.val @value
