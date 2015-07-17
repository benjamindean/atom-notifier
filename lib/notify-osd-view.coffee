{BufferedProcess} = require 'atom'
{CompositeDisposable, Disposable} = require 'atom'
path = require 'path'

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
        command = 'notify-send'
        icon = path.resolve(__dirname, '..', 'images', 'atom.png')
        args = ['-i', icon, Notification.message]
        args.push Notification.options.detail if Notification.options.detail
        process = new BufferedProcess({command, args})

    destroy: ->
        @subscriptions.dispose()
