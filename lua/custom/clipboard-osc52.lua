-- OSC 52 clipboard for SSH sessions (Neovim 10.0+ native support)
-- See :h clipboard-osc52

-- local function is_ssh()
--   return os.getenv("SSH_CONNECTION") ~= nil
--       or os.getenv("SSH_CLIENT") ~= nil
--       or os.getenv("SSH_TTY") ~= nil
-- end
--
-- if is_ssh() then
local function setup_osc52()
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy '+',
      ['*'] = require('vim.ui.clipboard.osc52').copy '*',
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste '+',
      ['*'] = require('vim.ui.clipboard.osc52').paste '*',
    },
  }
end

-- LOGIC:
-- 1. If we are in an SSH session (SSH_TTY), always use OSC 52.
-- 2. OR: If standard clipboard tools (xclip/wl-copy/pbcopy) are MISSING, use OSC 52.
if os.getenv 'SSH_TTY' ~= nil or (vim.fn.executable 'wl-copy' == 0 and vim.fn.executable 'xclip' == 0 and vim.fn.executable 'pbcopy' == 0) then
  setup_osc52()
end

-- return {}
