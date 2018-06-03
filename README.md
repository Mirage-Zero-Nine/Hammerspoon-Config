# Hammerspoon-Config

This repository contains some basic configurations that used in Hammerspoon.


## Introduction of Hammerspoon

[What's Hammerspoon](https://www.hammerspoon.org)

## Brief Configuration Introduction

### InputSwitch.lua

- Can automatically switch input source between applications.

This `.lua` file can automatically switch input source based on current application window. For instance, in an IDE window such as Intellij IDEA, input source will be focused in English. And in other window, for instance, iMessage, a different language input can be focused alternatively such as Chinese. 

The specific input source can be edited in `InputSwitch.lua`.

### MoveMouseBetweenScreen.lua

- Switch mouse focus between screen by hotkey

This `.lua` file is made for switching mouse between monitor. The default hotkey can be found in file.

### MoveWindowBetweenScreen.lua

- Move application window between screens.

This `.lua` file is for application window to switch between monitor, similar to previous moving mouse file.

### AutoSetWindow.lua

- Automatically place specific application window when it is focused.

This `.lua` configuration is for automatically set window size when specific window is currently focused. For instance, when switch to 1Password, it will automatically place this application's window into right side of current monitor, with 2/3 proportion of current monitor space taken.
