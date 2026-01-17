return {
  'nvim-orgmode/orgmode',
  name = 'orgmode',
  enabled = require('nixCatsUtils').enableForCategory 'kickstart-orgmode',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    { 'nvim-orgmode/telescope-orgmode.nvim', name = 'telescope_orgmode' },
    { 'nvim-orgmode/org-bullets.nvim', name = 'org_bullets' },
  },
  event = 'VeryLazy',
  ft = { 'org' },
  config = function()
    -- Only do auto grammar install when not using Nix
    if require('nixCatsUtils').lazyAdd(true, false) then
      require('orgmode').setup_ts_grammar()
    end

    require('orgmode').setup {
      org_agenda_files = '~/orgfiles/**/*',
      org_default_notes_file = '~/orgfiles/refile.org',
      org_startup_folded = 'showeverything',
    }

    pcall(function()
      require('org-bullets').setup()
    end)

    -- Org completion is handled by blink.cmp configuration.

    local orgmode_keymaps = vim.api.nvim_create_augroup('orgmode_keymaps', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
      group = orgmode_keymaps,
      pattern = 'org',
      callback = function(event)
        vim.keymap.set('n', '<leader>ii', function()
          vim.cmd('edit ' .. vim.fn.expand '~/orgfiles/refile.org')
        end, { buffer = event.buf, desc = 'Org: Open refile' })

        vim.keymap.set('n', '<leader>r', function()
          local telescope = require 'telescope'
          telescope.load_extension 'orgmode'
          telescope.extensions.orgmode.refile_heading()
        end, { buffer = event.buf, desc = 'Org: Refile heading' })

        vim.keymap.set('n', '<leader>sh', function()
          local telescope = require 'telescope'
          telescope.load_extension 'orgmode'
          telescope.extensions.orgmode.search_headings()
        end, { buffer = event.buf, desc = 'Org: Search headings' })

        vim.keymap.set('n', '<leader>li', function()
          local telescope = require 'telescope'
          telescope.load_extension 'orgmode'
          telescope.extensions.orgmode.insert_link()
        end, { buffer = event.buf, desc = 'Org: Insert link' })
      end,
    })
  end,
}
