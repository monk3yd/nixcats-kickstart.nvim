return {
  'pablopunk/pi.nvim',
  lazy = true,
  cmd = { 'PiAsk', 'PiAskSelection', 'PiCancel', 'PiLog' },
  keys = {
    { '<leader>aa', ':PiAsk<CR>', mode = 'n', desc = 'pi: ask about this' },
    { '<leader>aa', ':PiAskSelection<CR>', mode = 'x', desc = 'pi: ask about selection' },
  },
  opts = {
    provider = 'deepseek',
    model = 'deepseek-v4-pro',
    thinking = 'xhigh',
  },
}
