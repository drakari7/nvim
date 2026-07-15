local map = require('confs.utils').map
return {
  'nvim-lua/plenary.nvim',
  'tpope/vim-abolish', -- for :S [:Subvert] substitutions

  {
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
  },

  {
    'windwp/nvim-autopairs',
    opts = {},
  },

  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = "helix",
      delay = 500,
    },
  },

  {
    'nemanjamalesija/smart-paste.nvim',
    event = 'VeryLazy',
    config = function()
      require('smart-paste').setup()

      -- Paste in visual mode without yanking the pasted over content
      map('x', 'p', 'P')
      map('x', 'P', 'p')
    end,
  },


  {
    'brenoprata10/nvim-highlight-colors',
    opts = {
      render = 'background',      -- 'background' | 'foreground' | 'first_column' | 'virtual'
      enable_named_colors = true, -- don't match 'red', 'blue', etc.
      enable_tailwind = false,
    },
    keys = {
      { "<leader>co", "<cmd>HighlightColors Toggle<CR>", desc = "Toggle highlight colors" }
    }
  },

  -- File explorer
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-mini/mini.icons" },
    config = function()
      require("oil").setup({
        columns = { "icon", "size", "mtime" },
        view_options = { show_hidden = true }
      })

      map('n', '<leader>oi', '<cmd>Oil<CR>', "Open parent directory")
    end,
  },
}
