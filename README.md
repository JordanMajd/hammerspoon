# Hammerspoon

This is a script for [Hammerspoon](https://github.com/Hammerspoon/hammerspoon) that provides several features and productivity boosts for OSX.

If you like or are using this config, please give it a :star: for motivation :)

![Image of window management](/assets/example.gif)

## Features

 - Cross monitor window tiling using `cmd` + `alt` + `direction`
 - Window resizing using `ctrl` + `cmd` + `alt` + `direction`
 - Psuedo full screen using `cmd` + `alt` + `f`
 - Lock screen using `cmd` + `alt` + `l`
 - Disables window animations.
 - Redshift menubar item that allows variable screen temperature for easier night reading.
 - A 'caffeine' mode, which keeps the screen awake and disables notifications using `cmd` + `alt` + `c` or menubar.
 - A menubar dropdown to select primary screen resolution and DPI.
 - Automatically reloads when code is updated.

## Installation

1. Install [Hammerspoon](https://github.com/Hammerspoon/hammerspoon).
1. Clone repository into your `~/.hammerspoon` directory.
1. Open Hammerspoon or reload your config.

## Roadmap

- Update README image and description.
- Create documentation for each file.
- Implement a settings file to manage all keyboard shortcuts.
- Fix auto-reload to work consistently on all child directories.
- Implement pomadoro module.
- Make the window grid re-init on screen connect event so grids retain expected dimensions.
- Multimonitor support for screen resolution dropdown.
- Add Random.org random number generator to Conky.

## Issues / Suggestions

Feel free to open an issue to give me suggestions, feedback or let me know if something doesn't work.

## Credits

- Caffeine menu bar icon from [Brian Gilbert's config](https://github.com/BrianGilbert/.hammerspoon).

## Resources

- [Lua.org](http://www.lua.org/)
- [Learn Lua in Y Minutes](https://learnxinyminutes.com/docs/lua/)
- [Hammerspoon.org](http://www.hammerspoon.org/)

## License

- MIT, see [LICENSE](/LICENSE) for more details.
