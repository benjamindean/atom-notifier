# Native desktop notifications for Atom

Native desktop notifications for Atom with [node-notifier](https://github.com/mikaelbr/node-notifier).  

[Atom.io](https://atom.io/packages/atom-notifier)  | [GitHub](https://github.com/benjamindean/atom-notifier)

`apm install atom-notifier`

![atom-notifier](https://cloud.githubusercontent.com/assets/5139993/8745652/c1d9597c-2c8a-11e5-8c10-c8ed3af6722f.png)

##Currently tested on:

- [x] Arch Linux (GNOME 3.16)
- [x] Arch Linux (KDE Plasma 5)
- [x] Ubuntu 15.04 (Unity)
- [x] Windows 8
- [x] Windows 7
- [x] Windows XP

##Options

This package doesn't watch for option changes. To apply new settings, reload editor with <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>R</kbd>.

- Show only when editor is unfocused  
Description: Show desktop notifications only when editor is unfocused or minimized.  
Default: false

- Show editor notifications?  
Description: Which notifications to show in editor window.  
Default: 'Show All'  
Available: 'Show All', 'Show Errors and Fatal Errors', 'Hide All'  
NOTE: Some notifications has buttons or large description text, so, better to leave this option as "Show All" or "Show Errors and Fatal Errors".
