return {
  "dlyongemallo/diffview-plus.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  keys = {
    { "<leader>dh", "<cmd>DiffviewFileHistory %<cr>", desc = "File history (current file)" },
    { "<leader>dh", ":DiffviewFileHistory %<cr>", mode = 'x', desc = "Line history (visual selection)" },
    { "<leader>dH", "<cmd>DiffviewFileHistory<cr>", desc = "File history (repo)" },
    { "<leader>dc", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
    { "<leader>dt", "<cmd>DiffviewClose<cr>", desc = "Toggle diffview file panel" },
  },
}
