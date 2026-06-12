-- virtual_lines config used ONLY during jumpWithVirtualLineDiags.
-- Global vim.diagnostic.config keeps virtual_lines = false; this is enabled briefly.
local virtual_lines_config = {
	current_line = true,
	format = function (diagnostic)
		local code = diagnostic.code and (" [" .. diagnostic.code .. "]") or ""
		return string.format("%s: %s%s", diagnostic.source, diagnostic.message, code)
	end,
}

---@param jumpCount number
---@param severity? vim.diagnostic.SeverityFilter
local function jumpWithVirtualLineDiags(jumpCount, severity)
  -- NOTE: Wipe any prior autocmd BEFORE jumping, so CursorMoved from this jump can't fire the previous jump's "reset" callback.
  pcall(vim.api.nvim_del_augroup_by_name, "jumpWithVirtLineDiags")

  vim.diagnostic.jump { count = jumpCount, severity = severity }

  vim.diagnostic.config { virtual_lines = virtual_lines_config }

  vim.defer_fn(function() -- deferred to not trigger by jump itself
    local start_line = vim.fn.line('.')

    vim.api.nvim_create_autocmd("CursorMoved", {
      desc = "User: Reset diagnostics virtual lines on leaving the line",
      group = vim.api.nvim_create_augroup("jumpWithVirtLineDiags", {}),
      callback = function(ev)
        if vim.fn.line('.') == start_line then return end
        vim.diagnostic.config { virtual_lines = false }
        vim.api.nvim_del_augroup_by_id(ev.group) -- self-cleanup
      end,
    })
  end, 1)
end

local map = require('confs.utils').map

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "folke/lazydev.nvim", opts = {}, ft = "lua" }, -- For vim lua support with lsp
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
  },

  config = function()
    -- Default config merged into every LSP server (capabilities for completion, etc.).
    -- For per-server overrides use vim.lsp.config('<server>', { ... }) below.
    vim.lsp.config('*', {
      capabilities = require('blink.cmp').get_lsp_capabilities(),
    })

    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        -- "ruff",
        -- "rust_analyzer",
        "sqlls",
        "bashls",
        "jsonls",
        "taplo",
      },
    })

    local min_warn = { min = vim.diagnostic.severity.WARN }
    vim.diagnostic.config({
      signs = false,
      virtual_lines = false, -- off by default; jumpWithVirtualLineDiags enables briefly
    })

    map('n', '[D', function() jumpWithVirtualLineDiags(-1) end, 'Prev Diagnostic')
    map('n', ']D', function() jumpWithVirtualLineDiags( 1) end, 'Next Diagnostic')
    map('n', '[d', function() jumpWithVirtualLineDiags(-1, min_warn) end, 'Prev error')
    map('n', ']d', function() jumpWithVirtualLineDiags( 1, min_warn) end, 'Next error')

    map('n', '<leader>dp', vim.diagnostic.open_float, 'Diagnostic float on current line')
    map('n', '<leader>dq', vim.diagnostic.setqflist, 'Populate diagnostics in quickfix list')
    map('n', '<leader>dl', vim.diagnostic.setloclist, 'Populate diagnostics in loclist')

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        local opts = { buffer = ev.buf }
        map('n', 'gd', vim.lsp.buf.definition, 'Goto definition', opts)
        map('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration', opts)
        map('n', 'go', vim.lsp.buf.type_definition, 'Goto type definition', opts)
      end,
    })
  end
}
