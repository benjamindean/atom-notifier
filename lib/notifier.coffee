AtomNotifierView = require './notifier-view'

module.exports =
    config:
        unfocused:
            title: 'Show only when editor is unfocused'
            type: 'boolean'
            default: false

    atomNotifierView: null

    activate: (state) ->
        @atomNotifierView = new AtomNotifierView(state.atomNotifierViewState)

    deactivate: ->
        @atomNotifierView.destroy()

    serialize: ->
        atomNotifierViewState: @atomNotifierView.serialize()
