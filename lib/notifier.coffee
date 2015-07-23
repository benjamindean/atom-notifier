{CompositeDisposable, Disposable} = require 'atom'
path = require 'path'

notifier = null
subscriptions = null

module.exports =
    config:
        unfocused:
            title: 'Show only when editor is unfocused'
            description: 'Show desktop notifications only when editor is unfocused or minimized. \
                          Reload editor to apply settings.'
            type: 'boolean'
            default: false
        hideInEditor:
            title: 'Show editor notifications?'
            description: 'Which notifications to show in editor window. \
                          NOTE: Some notifications has buttons or large description text, so, \
                          better to leave this option as "Show All" or "Show Errors and Fatal Errors". \
                          Reload editor to apply settings.'
            type: 'string'
            enum: ['Show All', 'Show Errors and Fatal Errors', 'Hide All']
            default: 'Show All'

    activate: ->
        if navigator.appVersion.indexOf("NT 6.1") isnt -1
            @icon = path.resolve(__dirname, '..', 'images', 'atom16.ico')
        else
            @icon = path.resolve(__dirname, '..', 'images', 'atom.png')
        @configure()

    configure: ->
        hideInEditor = atom.config.get('atom-notifier.hideInEditor')
        unfocused = if hideInEditor isnt 'Show All' then false \
                    else atom.config.get('atom-notifier.unfocused')

        if unfocused
            window.addEventListener 'blur', => @add()
            window.addEventListener 'focus', => @deactivate()
        else
            @add()

        if hideInEditor isnt 'Show All'
            hide = document.createElement('style')
            if hideInEditor is 'Show Errors and Fatal Errors'
                hide.textContent = "atom-notification.info, \
                                    atom-notification.warning, \
                                    atom-notification.success {display: none;}"
            else
                hide.textContent = "atom-notification {display: none;}"
            atom.styles.addStyleElement(hide)
        else
            if hide? then atom.styles.removeStyleElement(hide)

    loadNotifier: ->
        notifier ?= require 'node-notifier'

    add: ->
        subscriptions = new CompositeDisposable
        subscriptions.add atom.notifications.onDidAddNotification (Notification) => @send Notification

    send: (Notification) ->
        @loadNotifier()
        params = {
            'title': Notification.getMessage()
            'message': Notification.getDetail() ? atom.workspace.getActivePaneItem().getTitle()
            'icon': @icon
            'contentImage': path.resolve(__dirname, '..', 'images', 'atom.png')
        }
        notifier.notify(params)

    deactivate: ->
        subscriptions?.dispose()
