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
         name = "C_x",
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
   {
      key = 'Space',
      mods = 'CTRL',
      action = wezterm.action.ActivateCopyMode,
   },
   -- cycle tabs
   {
      key = 'Tab',
      mods = 'CTRL',
      action = wezterm.action.ActivateTabRelative(1),
   },
   -- up, left, right, down
   {
      key = 'p',
      mods = 'CTRL',
      action = wezterm.action.SendKey { key = 'UpArrow' },
   },
   {
      key = 'b',
      mods = 'CTRL',
      action = wezterm.action.SendKey { key = 'LeftArrow' },
   },
   {
      key = 'f',
      mods = 'CTRL',
      action = wezterm.action.SendKey { key = 'RightArrow' },
   },
   {
      key = 'n',
      mods = 'CTRL',
      action = wezterm.action.SendKey { key = 'DownArrow' },
   },
}

config.key_tables = {
   -- C-x key table
   C_x = {
      -- C-x 0 closes current window TODO: C-x 1: I don't immediately see CloseOtherPanes or similar
      { key = '0', action = wezterm.action.CloseCurrentPane { confirm = true } },
      -- C-x 2 or 3 splits windows
      { key = '2', action = wezterm.action.SplitVertical },
      { key = '3', action = wezterm.action.SplitHorizontal },
      -- C-x t activates the tab key table
      { key = 't', action = wezterm.action.ActivateKeyTable { name = "C_x_t", one_shot = true } },
   },
   -- C-x t key table (tabs)
   C_x_t = {
      -- C-x t 0 closes current tab
      { key = '0', action = wezterm.action.CloseCurrentTab { confirm = true } },
      -- C-x t 2 creates a new tab
      { key = '2', action = wezterm.action.SpawnTab 'DefaultDomain' },
   },
   -- make behavior in CopyMode similar to regular behavior
   copy_mode = {
      -- select
      { key = 'Space', mods = 'NONE', action = wezterm.action.CopyMode { SetSelectionMode = 'Cell' } },
      -- movement
      { key = 'p', mods = 'CTRL', action = wezterm.action.CopyMode 'MoveUp' },
      { key = 'UpArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveUp' },
      { key = 'b', mods = 'CTRL', action = wezterm.action.CopyMode 'MoveLeft' },
      { key = 'LeftArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveLeft' },
      { key = 'f', mods = 'CTRL', action = wezterm.action.CopyMode 'MoveRight' },
      { key = 'RightArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveRight' },
      { key = 'n', mods = 'CTRL', action = wezterm.action.CopyMode 'MoveDown' },
      { key = 'DownArrow', mods = 'NONE', action = wezterm.action.CopyMode 'MoveDown' },
      -- quit
      {
        key = 'Escape',
        mods = 'NONE',
        action = wezterm.action.Multiple {
          { CopyMode = 'MoveToScrollbackBottom' },
          { CopyMode = 'Close' },
        },
      },
      {
        key = 'g',
        mods = 'CTRL',
        action = wezterm.action.Multiple {
          { CopyMode = 'MoveToScrollbackBottom' },
          { CopyMode = 'Close' },
        },
      },
      -- copy
      {
         key = 'w',
         mods = 'ALT',
         action = wezterm.action.Multiple {
            { CopyTo = 'ClipboardAndPrimarySelection' },
            { CopyMode = 'ClearSelectionMode' },
         },
      },
   },
}

-- Return the configuration to wezterm
return config
