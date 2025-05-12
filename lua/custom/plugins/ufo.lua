return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
    {
      'luukvbaal/statuscol.nvim',
      config = function()
        local builtin = require 'statuscol.builtin'
        require('statuscol').setup {
          relculright = true,
          segments = {
            { text = { builtin.foldfunc }, click = 'v:lua.ScFa' },
            { text = { '%s' }, click = 'v:lua.ScSa' },
            { text = { builtin.lnumfunc, ' ' }, click = 'v:lua.ScLa' },
          },
        }
      end,
    },
  },
  config = function()
    local ufo = require 'ufo'
    ufo.setup {
      open_fold_hl_timeout = 150,
      close_fold_kinds_for_lt = { 'imports', 'comment' },
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = 'Normal:Folded',
          winblend = 0,
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
        },
      },
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    }

    vim.o.foldcolumn = '1' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open All Folds' })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close All Folds' })
    vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith, { desc = 'Close Folds With' })
    vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds, { desc = 'Close Folds Except' })

    vim.keymap.set('n', '<leader>z', 'za', { silent = true, desc = 'Toogle Fold' })
  end,
}
