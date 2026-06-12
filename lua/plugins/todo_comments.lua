return {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  lazy = false,

  opts = {
    signs = false,
    merge_keywords = false,
    highlight = {
      multiline = false,
      keyword = "bg",
    }
  },

  keys = {
    { ']t', function() require("todo-comments").jump_next() end, desc = 'Next todo comment' },
    { '[t', function() require("todo-comments").jump_prev() end, desc = 'Previous todo comment' },
    { '<leader>tq', '<cmd>TodoQuickFix keywords=TODO<cr>', desc = 'Todos (quickfix)' },
  },
}
