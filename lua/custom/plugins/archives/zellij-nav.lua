return {
  'swaits/zellij-nav.nvim',

  -- Archived: this plugin steals `<C-hjkl>` for zellij pane navigation.
  -- It can conflict with normal split navigation (`smart-splits.nvim`).
  enabled = false,

  lazy = true,
  event = 'VeryLazy',
  keys = {
    { '<c-h>', '<cmd>ZellijNavigateLeft<cr>', { silent = true, desc = 'navigate left' } },
    { '<c-j>', '<cmd>ZellijNavigateDown<cr>', { silent = true, desc = 'navigate down' } },
    { '<c-k>', '<cmd>ZellijNavigateUp<cr>', { silent = true, desc = 'navigate up' } },
    { '<c-l>', '<cmd>ZellijNavigateRight<cr>', { silent = true, desc = 'navigate right' } },
  },
  opts = {},
  config = function()
    require('zellij-nav').setup()

    vim.api.nvim_create_autocmd('VimLeave', {
      pattern = '*',
      command = 'silent !zellij action switch-mode normal',
    })
  end,
}
