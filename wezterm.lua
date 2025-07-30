-- Config & Lua reference: https://wezterm.org/config/lua/general.html

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Apply config choices

config.enable_scroll_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- This should apply some emacs-like key bindings
config.keys = {
   -- activate C-x key table
   {
      key = 'x',
      mods = 'CTRL',
      action = wezterm.action.ActivateKeyTable {
         name = "c_x",
         one_shot = true,
      },
   },
   -- move between windows
   {
      key = 'LeftArrow',
      mods = 'SHIFT',
      action = wezterm.action.ActivatePaneDirection 'Left',
   },
   {
      key = 'RightArrow',
      mods = 'SHIFT',
      action = wezterm.action.ActivatePaneDirection 'Right',
   },
   {
      key = 'UpArrow',
      mods = 'SHIFT',
      action = wezterm.action.ActivatePaneDirection 'Up',
   },
   {
      key = 'DownArrow',
      mods = 'SHIFT',
      action = wezterm.action.ActivatePaneDirection 'Down',
   },
   -- search
   {
      key = 's',
      mods = 'CTRL',
      action = wezterm.action.Search 'CurrentSelectionOrEmptyString',
   },
   -- kill+yank A.K.A. Copy and Paste
   {
      key = 'w',
      mods = 'ALT',
      action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection',
   },
   {
      key = 'y',
      mods = 'CTRL',
      action = wezterm.action.PasteFrom 'Clipboard',
   },
}

config.key_tables = {
   c_x = {
      -- C-x 0 closes current window TODO: C-x 1: I don't immediately see CloseOtherPanes or similar
      { key = '0', action = wezterm.action.CloseCurrentPane { confirm = true } },
      -- C-x 2 or 3 splits windows
      { key = '2', action = wezterm.action.SplitVertical },
      { key = '3', action = wezterm.action.SplitHorizontal },
   },
}

-- Return the configuration to wezterm
return config
