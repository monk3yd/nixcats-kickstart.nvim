return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Recommended for `ask()` and `select()`.
    -- Required for `toggle()`.
    { 'folke/snacks.nvim', opts = { input = {}, picker = {} } },
  },
  config = function()
    vim.g.opencode_opts = {
      -- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on `opencode_opts`.
      --
      -- FIX can we configure for the opencode agent to know that
      -- the request is comming from neovim CWD?
      port = 3002,
      on_send = function() end,
      on_opencode_not_found = function() end,
    }

    -- Required for `vim.g.opencode_opts.auto_reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ 'n', 'x' }, '<leader>aa', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'opencode: Ask about this' })

    vim.keymap.set({ 'n', 'x' }, '<leader>as', function()
      require('opencode').select()
    end, { desc = 'opencode: Select prompt' })

    vim.keymap.set({ 'n', 'x' }, '<leader>a+', function()
      require('opencode').prompt '@this'
    end, { desc = 'opencode: Add this' })

    -- vim.keymap.set('n', '<leader>at', function()
    --   require('opencode').toggle()
    -- end, { desc = 'opencode: Toggle embedded' })

    vim.keymap.set('n', '<leader>ac', function()
      require('opencode').command()
    end, { desc = 'opencode: Select command' })

    vim.keymap.set('n', '<leader>an', function()
      require('opencode').command 'session_new'
    end, { desc = 'opencode: New session' })

    vim.keymap.set('n', '<leader>ai', function()
      require('opencode').command 'session_interrupt'
    end, { desc = 'opencode: Interrupt session' })

    vim.keymap.set('n', '<leader>aA', function()
      require('opencode').command 'agent_cycle'
    end, { desc = 'opencode: Cycle selected agent' })

    vim.keymap.set('n', '<S-C-u>', function()
      require('opencode').command 'messages_half_page_up'
    end, { desc = 'opencode: Messages half page up' })

    vim.keymap.set('n', '<S-C-d>', function()
      require('opencode').command 'messages_half_page_down'
    end, { desc = 'opencode: Messages half page down' })
  end,
}
