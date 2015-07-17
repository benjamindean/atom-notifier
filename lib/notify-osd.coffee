AtomNotifyOsdView = require './notify-osd-view'

module.exports =
    config:
        unfocused:
            title: 'Show only when editor is unfocused'
            type: 'boolean'
            default: false

    atomNotifyOsdView: null

    activate: (state) ->
        @atomNotifyOsdView = new AtomNotifyOsdView(state.atomNotifyOsdViewState)

    deactivate: ->
        @atomNotifyOsdView.destroy()

    serialize: ->
        atomNotifyOsdViewState: @atomNotifyOsdView.serialize()
