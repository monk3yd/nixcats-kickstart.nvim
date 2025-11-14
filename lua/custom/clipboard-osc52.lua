-- OSC 52 clipboard for SSH sessions (Neovim 10.0+ native support)
-- See :h clipboard-osc52

local function is_ssh()
  return os.getenv("SSH_CONNECTION") ~= nil 
      or os.getenv("SSH_CLIENT") ~= nil 
      or os.getenv("SSH_TTY") ~= nil
end

if is_ssh() then
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end

return {}
