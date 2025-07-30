# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a WezTerm terminal emulator configuration written in Lua. The main configuration file is `wezterm.lua` which customizes WezTerm with Emacs-inspired key bindings and UI preferences.

## Development Commands

Since this is a configuration file project, there are no build or test commands. Configuration changes are applied by:

- **Reload configuration**: `CTRL+SHIFT+R` in WezTerm
- **Test configuration**: Launch WezTerm to automatically load `wezterm.lua`

## Configuration Architecture

The configuration follows WezTerm's standard Lua API patterns:

- **Main config object**: Created with `wezterm.config_builder()`
- **Key bindings**: Defined in `config.keys` array using `wezterm.action` objects
- **Key tables**: Complex key sequences defined in `config.key_tables` (e.g., `c_x` table for Ctrl+X prefix)
- **UI settings**: Direct property assignments on the config object

## Key Binding System

The configuration implements a hierarchical key binding system:

1. **Direct bindings**: Single key combinations in `config.keys`
2. **Prefix bindings**: Ctrl+X activates the `c_x` key table for multi-key sequences
3. **Emacs-style conventions**: Copy/paste (Alt+W/Ctrl+Y), search (Ctrl+S), window management

## Configuration File Structure

- **API setup**: `require 'wezterm'` and `config_builder()`
- **UI preferences**: Scrollbar and tab bar settings
- **Key bindings**: Navigation, text operations, and window management
- **Key tables**: Multi-step key sequences
- **Export**: Return config object to WezTerm

When modifying key bindings, ensure actions use the proper `wezterm.action` constructors and follow the existing patterns for consistency.