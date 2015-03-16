{$, View} = require 'atom-space-pen-views'

module.exports =
class ResizablePanel extends View

  @content: (data)->
    @div class: 'resizable-panel tool-panel', =>
      @div class: 'view-scroller', =>
        @subview 'content', data
      @div class: 'resize-handle', outlet: 'resizeHandle'

  initialize: (data)->
    @position = 'bottom'

    @resizeHandle.attr position: @position

    @on 'dblclick', '.resize-handle', => @resizeToFitContent()
    @on 'mousedown', '.resize-handle', (e) => @resizeStarted(e)

    switch @position
      when 'bottom'
        @height 200
        atom.workspace.addBottomPanel(item: this)
      when 'top'
        @height 200
        atom.workspace.addTopPanel(item: this)
      when 'left'
        @width 200
        atom.workspace.addLeftPanel(item: this)
      when 'right'
        @width 200
        atom.workspace.addRightPanel(item: this)


  resizeStarted: =>
    @focusElement = document.activeElement
    $(document).on('mousemove', @resizeView)
    $(document).on('mouseup', @resizeStopped)

  resizeStopped: =>
    $(document).off('mousemove', @resizeView)
    $(document).off('mouseup', @resizeStopped)
    @focusElement?.focus()
    @focusElement = null

  resizeView: ({pageX, pageY, which}) =>
    return @resizeStopped() unless which is 1

    switch @position
      when 'bottom'
        @height Math.min @content.height(), $(document.body).height() - pageY
      when 'top'
        @height Math.min @content.height(), pageY
      when 'left'
        @width Math.min @content.width(), pageX
      when 'right'
        @width Math.min @content.width(), $(document.body).width() - pageX

  resizeToFitContent: ->
    @width('100%')
    @height(200)
