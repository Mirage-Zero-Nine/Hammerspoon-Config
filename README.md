# Hammerspoon-Config

This repository contains some basic configurations that used in Hammerspoon.


## Introduction of Hammerspoon

[What's Hammerspoon](https://www.hammerspoon.org)

## How to install

Download all `.lua` files and put them into Hammerspoon configuration folder. Reload configiration in Hammerspoon.

## Brief Configuration Introduction

### : automatically switch input source between applications

Automatically switch input source based on current application window. For instance, in an IDE window such as Intellij IDEA, input source will be focused in English. And in other window, for instance, iMessage, a different language input can be focused alternatively such as Chinese. 

The specific input source can be edited in `InputSwitch.lua`.

### MoveMouseBetweenScreen.lua: switch mouse focus between screen by hotkey

Switching **mouse** between monitor. The default hotkey can be found in file.

### MoveWindowBetweenScreen.lua: move application window between screens

Switching **application** window between monitor, similar to previous moving mouse file.

### AutoSetWindow.lua: automatically set application window to a specific position and layout

Automatically assign window size and position when application window is focused at current display. For instance, when 1Password window is focused, it will automatically place this application's window into right side of current monitor, with 2/3 proportion of current monitor space taken. 

Application and position can be modified in `AutoSetWindow.lua` file.
