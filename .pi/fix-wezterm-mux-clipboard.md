# Fix WezTerm Mux Clipboard

## Problem

Neovim clipboard (`"+y`, `"*y`) fails with "No provider" in WezTerm SSH mux
sessions — but only in tabs spawned after the initial attach. Tab 1 works;
tabs 2+ don't.

## Root Cause

`clipboard-osc52.lua` detects when to use OSC 52 with three conditions:

1. `SSH_TTY` is set → tab 1 (SSH login PTY) ✓
2. `ZELLIJ` is set → zellij sessions ✓
3. `wl-copy`/`xclip`/`pbcopy` are missing ✓

Tabs spawned via `leader+c` inside the mux are created by
`wezterm-mux-server`, which does NOT inherit `SSH_TTY`. And `wl-copy` IS
present on localhost (same machine), so condition 3 doesn't trigger.
Neovim falls through to `wl-copy` directly → fails because
`WAYLAND_DISPLAY` isn't forwarded through the SSH mux session.

## Fix

Added a 4th condition to `lua/custom/clipboard-osc52.lua`:

```lua
or (os.getenv('WEZTERM_EXECUTABLE') ~= nil
    and os.getenv('WAYLAND_DISPLAY') == nil
    and os.getenv('DISPLAY') == nil)
```

"If we're in wezterm AND no display socket is available, use OSC 52."

- Tab 1: still caught by `SSH_TTY` ✓
- Tab 2+: caught by `WEZTERM_EXECUTABLE` + missing display ✓
- Local wezterm: `WEZTERM_EXECUTABLE` set but `WAYLAND_DISPLAY` IS set → `wl-copy` direct ✓

## Files Changed

- `lua/custom/clipboard-osc52.lua` — added one condition block

## Test

1. Attach to rftl mux (`leader+a`)
2. Spawn new tab (`leader+c`)
3. Open neovim, yank with `"+y`
4. Paste elsewhere → clipboard should work
