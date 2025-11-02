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
      port = 3000,
      on_send = function() end,
      on_opencode_not_found = function() end,
    }

    -- Required for `vim.g.opencode_opts.auto_reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'opencode: Ask about this' })

    vim.keymap.set({ 'n', 'x' }, '<leader>os', function()
      require('opencode').select()
    end, { desc = 'opencode: Select prompt' })

    vim.keymap.set({ 'n', 'x' }, '<leader>o+', function()
      require('opencode').prompt '@this'
    end, { desc = 'opencode: Add this' })

    -- vim.keymap.set('n', '<leader>ot', function()
    --   require('opencode').toggle()
    -- end, { desc = 'opencode: Toggle embedded' })

    vim.keymap.set('n', '<leader>oc', function()
      require('opencode').command()
    end, { desc = 'opencode: Select command' })

    vim.keymap.set('n', '<leader>on', function()
      require('opencode').command 'session_new'
    end, { desc = 'opencode: New session' })

    vim.keymap.set('n', '<leader>oi', function()
      require('opencode').command 'session_interrupt'
    end, { desc = 'opencode: Interrupt session' })

    vim.keymap.set('n', '<leader>oA', function()
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
