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
      org_agenda_files = {
        '~/drive/org/inbox.org',
        '~/drive/org/projects.org',
        '~/drive/org/areas.org',
        '~/drive/org/archive.org',
      },
      org_default_notes_file = '~/drive/org/inbox.org',
      org_startup_folded = 'showeverything',
      mappings = {
        org = {
          -- In most terminals, `<Tab>` and `<C-i>` are the same key.
          -- Disable Org cycling so Tab is free (use ufo/normal fold keys).
          org_cycle = false,
          org_global_cycle = false,

          -- 2. MAKE ENTER FOLLOW LINKS
          -- This maps <Enter> to "Open at point"
          -- org_open_at_point = '<CR>',
        },
      },
    }

    pcall(function()
      require('org-bullets').setup()
    end)

    -- Org completion is handled by blink.cmp configuration.

    -- Global keymap for quick idea dumping.
    vim.keymap.set('n', '<leader>ii', function()
      vim.cmd('edit ' .. vim.fn.expand '~/drive/org/inbox.org')
    end, { desc = 'Org: Open inbox' })

    local orgmode_keymaps = vim.api.nvim_create_augroup('orgmode_keymaps', { clear = true })

    vim.api.nvim_create_autocmd('FileType', {
      group = orgmode_keymaps,
      pattern = 'org',
      callback = function(event)
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
