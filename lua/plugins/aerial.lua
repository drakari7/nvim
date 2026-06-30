return {
  'stevearc/aerial.nvim',
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.icons",
  },
  keys = {
    { "<leader>ao", function() require('aerial').toggle({ focus = false }) end, desc = 'Aerial toggle' },
    { "<leader>an", function() require('aerial').nav_toggle() end,              desc = 'Aerial nav toggle' },
    { "<leader>af", function() require('aerial').focus() end,                   desc = 'Aerial focus' },
    { "<leader>ac", function() require('aerial').close_all() end,               desc = 'Aerial Close all' },
  },
  opts = {
    layout = {
      max_width = { 30, 0.16 },
      min_width = { 15, 0.1 },
      default_direction = "right",
    },

    close_automatic_events = { "unsupported" },
    show_guides = true,

    manage_folds = true,
    link_tree_to_folds = true,
    -- link_folds_to_tree = true,

    highlight_on_jump = false, -- Set a value in milliseconds or false to disable
    nav = {
      min_height = { 30, 0.6 },
      min_width = { 20, 0.3 },
      preview = true,
      win_opts = {
        cursorline = false,
      },
      keymaps = {
        ["q"] = "actions.close",
      }
    }
  },
}
