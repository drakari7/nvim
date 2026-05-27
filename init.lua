vim.loader.enable()
--------------------------------------------------------------
-- Sourcing config files
-----------------------------------------------------------
require('confs.options')
require('confs.keybindings')
require('confs.lazy')

-- idk why but the tabs dont work unless i set colorscheme twice
vim.cmd([[colorscheme gruvbox]])
vim.cmd([[colorscheme gruvbox]])
