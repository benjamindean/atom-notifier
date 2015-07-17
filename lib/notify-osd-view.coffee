{BufferedProcess} = require 'atom'
{CompositeDisposable, Disposable} = require 'atom'
path = require 'path'
notifier = require 'node-notifier'

module.exports =
class AtomNotifyOsdView
    constructor: ->
        if process.platform is 'linux'
            if atom.config.get('notify-osd.unfocused')
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
          'title': Notification.message,
          'message': Notification.options.detail ? Notification.message,
          'icon': path.resolve(__dirname, '..', 'images', 'atom.png')
        }
        notifier.notify(params)

    destroy: ->
        @subscriptions.dispose()
