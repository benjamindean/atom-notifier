{CompositeDisposable, Disposable} = require 'atom'
path = require 'path'
notifier = require 'node-notifier'

module.exports =
class AtomNotiferView
    constructor: ->
        if atom.config.get('atom-notifier.unfocused')
            window.addEventListener 'blur', =>
                @add()
            window.addEventListener 'focus', =>
                @destroy()
        else
            @add()

    add: ->
        @subscriptions = new CompositeDisposable
        @listener = atom.notifications.onDidAddNotification (Notification) => @send Notification
        @subscriptions.add @listener

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
