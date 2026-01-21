return {
  'chipsenkbeil/org-roam.nvim',
  name = 'org-roam.nvim',
  enabled = require('nixCatsUtils').enableForCategory 'kickstart-orgmode',

  -- Make this non-lazy so `require('org-roam')` works immediately.
  lazy = false,

  dependencies = {
    -- org-roam.nvim is built on top of orgmode
    { 'nvim-orgmode/orgmode', name = 'orgmode' },
  },
  config = function()
    require('org-roam').setup {
      directory = '~/drive/org/roam',
      -- optional
      org_files = {
        '~/drive/org',
      },
    }
  end,
}
