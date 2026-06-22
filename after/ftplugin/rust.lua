local buf_map = require('confs.utils').buf_map
buf_map('n', '<leader>rr', ':w<CR>:!cargo run<CR>', 'Execute file')

buf_map("n", "gra", function() vim.cmd.RustLsp("codeAction") end, "Code Action")
buf_map("n", "K", function() vim.cmd.RustLsp({ "hover", "actions" }) end, "Hover")
buf_map("n", "<leader>rd", function() vim.cmd.RustLsp("relatedDiagnostics") end, "Related Diagnostics")
buf_map("n", "<leader>rc", function() vim.cmd.RustLsp("openCargo") end, "Open Cargo.toml")

-- Format-on-save handled by conform.nvim
