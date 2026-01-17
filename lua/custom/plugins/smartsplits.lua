return {
  'mrjones2014/smart-splits.nvim',
  config = function()
    local ss = require 'smart-splits'

    ss.setup {
      -- Enable zellij integration so split navigation can cross the boundary.
      -- This lets `<C-hjkl>` move within Neovim splits, and when at the edge,
      -- it asks zellij to move focus to the adjacent pane.
      multiplexer_integration = 'zellij',

      -- At the edge, hand off to zellij.
      at_edge = 'wrap',

      -- If zellij focus can't move, allow it to switch tabs.
      zellij_move_focus_or_tab = true,
    }

    -- Moving between splits (Matches your WezTerm keys)
    vim.keymap.set('n', '<C-h>', ss.move_cursor_left)
    vim.keymap.set('n', '<C-j>', ss.move_cursor_down)
    vim.keymap.set('n', '<C-k>', ss.move_cursor_up)
    vim.keymap.set('n', '<C-l>', ss.move_cursor_right)

    -- Resizing splits (Optional, but handy)
    vim.keymap.set('n', '<A-h>', ss.resize_left)
    vim.keymap.set('n', '<A-j>', ss.resize_down)
    vim.keymap.set('n', '<A-k>', ss.resize_up)
    vim.keymap.set('n', '<A-l>', ss.resize_right)
  end,
}
