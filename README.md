
# SAGE
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
![Travis CI Build Status](https://travis-ci.com/sgalland/sage.svg?branch=master)

Sierra Adventure Game Emulator written in Haxe

## Recommended Development Setup
The standard environment used for development is as follows:
* [Haxe 4.2.12](https://haxe.org/download/) - Currently this project is keeping current with the latest Haxe release.
* [Visual Studio Code](https://code.visualstudio.com/)
* [Haxe Extension Pack (for vscode, recommended rather than installing individual extensions)](https://marketplace.visualstudio.com/items?itemName=vshaxe.haxe-extension-pack)
* [Haxe Checkstyle (for vscode)](https://marketplace.visualstudio.com/items?itemName=vshaxe.haxe-checkstyle)
* [Lime/OpenFL Extension (for vscode)](https://marketplace.visualstudio.com/items?itemName=openfl.lime-vscode-extension)

Use OpenFL to build (see below) and a debugging configuration is included for Visual Studio Code.

## Quick Commands to install VSCode Extensions
````
code --install-extension vshaxe.haxe-extension-pack
code --install-extension vshaxe.haxe-checkstyle
code --install-extension openfl.lime-vscode-extension
````

## Required Haxelib's and Setup Commands
````
haxelib install dox
haxelib install checkstyle
haxelib install hxcpp
haxelib install openfl
haxelib run openfl setup
haxelib run lime setup
haxelib git sage-agi https://github.com/sgalland/sage-agi.git
haxelib dev sage-agi ./sage-agi
````

## Build Commands
Use normal OpenFL build methods. Can even be built from Visual Studio Code. e.g.
````
openfl test windows
````
