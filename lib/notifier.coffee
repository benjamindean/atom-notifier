{CompositeDisposable, Disposable} = require 'atom'
path = require 'path'
notifier = require 'node-notifier'

module.exports =
    config:
        unfocused:
            title: 'Show only when editor is unfocused'
            type: 'boolean'
            default: false

    activate: (state) ->
        if atom.config.get('atom-notifier.unfocused')
            window.addEventListener 'blur', =>
                @add()
            window.addEventListener 'focus', =>
                @destroy()
        else
            @add()

    add: ->
        @subscriptions = new CompositeDisposable
        @subscriptions.add atom.notifications.onDidAddNotification (Notification) => @send Notification

    send: (Notification) ->
        params = {
          'title': Notification.message
          'message': Notification.options.detail ? atom.workspace.getActivePaneItem().getTitle()
          'icon': path.resolve(__dirname, '..', 'images', 'atom.png')
          'contentImage': path.resolve(__dirname, '..', 'images', 'atom.png')
        }
        notifier.notify(params)

    destroy: ->
        @subscriptions.dispose()
