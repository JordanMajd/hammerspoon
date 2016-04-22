# NOTES AND SUCH

```bash
sudo defaults write /System/Library/LaunchAgents/com.apple.notificationcenterui KeepAlive -bool False
```

```
lordbunson: what sort of commands do you want to run? We have hs.execute() which is really simple and blocks while the command runs, or you can use hs.task for
            excellent features (like running a command in the background)
Ng: and for files, we don't provide anything specific, but there are the stock Lua library functions (specifically, the 'io' library)
Ng:http://lua-users.org/wiki/IoLibraryTutorial is probably going to cover what you need for handling files
< Ng:(although if you are using files to store settings/data, you might want to look at whether hs.settings can cover your needs)
```

# TODO

- full menu / config
- multimonitor window support
- redshift menu
- conki dash
- mouse accel, mouse size, scroll stuff
- trackpad accel, trackpad size, scroll stuff
- add keyboard layout with alt and cmd swapped
