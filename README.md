# Hammerspoon ![Version 0.8](https://img.shields.io/badge/Version-0.7-green.svg)

[![MIT licensed](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)
![Built with love](https://img.shields.io/badge/built%20with-%E2%9D%A4-FF8080.svg)

This is a script for [Hammerspoon](https://github.com/Hammerspoon/hammerspoon) that provides several features and automations for OSX.

![Image of window management](/assets/example.gif)

## Features

 - Cross monitor window tiling using `cmd` + `alt` + `direction`
 - Window resizing using `ctrl` + `cmd` + `alt` + `direction`
 - Psuedo full screen using `cmd` + `alt` + `f`
 - Lock screen using `cmd` + `alt` + `l`
 - Disables window animations.
 - Redshift menubar item that allows variable screen temperature for easier night reading.
 - A menubar dropdown to select primary screen resolution and DPI.
 - Automatically reloads when code is updated.

## Installation

1. Install [Hammerspoon](https://github.com/Hammerspoon/hammerspoon) and ensure it has accessibility rights in your privacy settings.
1. Clone repository into your `~/.hammerspoon` directory.
1. Open Hammerspoon or reload your config.

Enable or disable features by commenting them out in the `init.lua` file.

## Roadmap

- Make the window grid re-init on screen connect event so grids retain expected dimensions
- Multimonitor support for screen resolution dropdown
- Fix auto-reload to work consistently on all child directories
- Add Random.org random number generator
- Implement pomadoro module

## Issues / Suggestions

Feel free to open an issue to give me suggestions, feedback or let me know if something doesn't work.

## Resources

- [Lua.org](http://www.lua.org/)
- [Learn Lua in Y Minutes](https://learnxinyminutes.com/docs/lua/)
- [Hammerspoon.org](http://www.hammerspoon.org/)

## License

- MIT, see [LICENSE](/LICENSE) for more details.
