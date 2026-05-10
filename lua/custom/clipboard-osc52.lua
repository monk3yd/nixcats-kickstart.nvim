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
-- 1. If inside SSH.
-- 2. Or inside Zellij (so clipboard works identically local and remote).
-- 3. Or system clipboard tools are missing.
-- 4. Or inside wezterm but no display socket (mux tabs 2+).
if
  os.getenv 'SSH_TTY' ~= nil
  or os.getenv 'ZELLIJ' ~= nil
  or (vim.fn.executable 'wl-copy' == 0 and vim.fn.executable 'xclip' == 0 and vim.fn.executable 'pbcopy' == 0)
  or (os.getenv 'WEZTERM_EXECUTABLE' ~= nil
      and os.getenv 'WAYLAND_DISPLAY' == nil
      and os.getenv 'DISPLAY' == nil)
then
  setup_osc52()
end

-- return {}
