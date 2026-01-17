-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  -- NOTE: nixCats: return true only if category is enabled, else false
  enabled = require('nixCatsUtils').enableForCategory("kickstart-autopairs"),
  event = 'InsertEnter',
  config = function()
    require('nvim-autopairs').setup {}

    -- nvim-cmp integration (kept for context):
    -- If you want to automatically add `(` after selecting a function or method
    -- local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    -- local cmp = require 'cmp'
    -- cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    -- This config uses blink.cmp instead of nvim-cmp.
    -- blink.cmp has its own auto-bracket support; if you still prefer autopairs,
    -- you can keep it enabled without wiring it to completion events.
  end,
}
