return {
  'nvim-neorg/neorg',
  enabled = require('nixCatsUtils').enableForCategory 'kickstart-neorg',
  lazy = false,
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('neorg').setup {
      load = {
        ['core.defaults'] = {},
        ['core.concealer'] = {},
        ['core.summary'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/neorg/notes',
              gtd = '~/neorg/gtd',
            },
            default_workspace = 'gtd',
          },
        },
      },
    }
    vim.keymap.set('n', '<Leader>ii', '<cmd>Neorg index<CR>', { desc = '[norg]: Open Index of current workspace' })
    vim.keymap.set('n', '<Leader>io', function()
      vim.cmd 'e ~/neorg/gtd/inbox.norg'
    end, { desc = '[norg]: Open Inbox' })

    vim.wo.foldlevel = 99
    vim.wo.conceallevel = 2
  end,
}
