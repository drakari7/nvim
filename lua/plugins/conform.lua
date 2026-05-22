return {
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = { 'mason-org/mason.nvim' },
    lazy = false,
    opts = {
      -- Auto-installs the formatters conform.nvim invokes below.
      -- rustfmt is intentionally omitted — it ships with rustup, not mason.
      ensure_installed = {
        -- 'stylua',    -- lua
        'shfmt',        -- sh / bash
        -- 'black',     -- python formatter
        -- 'isort',     -- python imports sorting
        -- 'autoflake', -- python
      },
      run_on_start = true,
      auto_update  = false, -- bumps via :MasonToolsUpdate only
      start_delay  = 2000,  -- don't fight the initial UI render
      integrations = {
        ['mason-lspconfig'] = true,
        ['mason-null-ls'] = false,
        ['mason-nvim-dap'] = false,
      }
    },
  },

  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd   = { 'ConformInfo' },
    opts  = function()
      local pyproject_root = require('conform.util').root_file({ 'pyproject.toml' })
      return {
        formatters_by_ft = {
          python = { 'autoflake', 'isort', 'black' },
          -- lua    = { 'stylua' }, -- stylua is too aggressive; gf falls back to lua_ls's built-in formatter
          sh     = { 'shfmt' },
          bash   = { 'shfmt' },
          rust   = { 'rustfmt' },
        },
        formatters = {
          autoflake = { cwd = pyproject_root },
          isort     = { cwd = pyproject_root },
          black     = { cwd = pyproject_root },
        },
        format_on_save = function(bufnr)
          local enable_fts = {
            rust = true,
            python = true,
          }
          if not enable_fts[vim.bo[bufnr].filetype] then
            return
          else
            return {
              timeout_ms = 1000,
              -- lsp_format = 'fallback'
            }
          end
        end,
      }
    end,
    keys = {
      {
        'gf',
        mode = { 'n', 'x' },
        function() require('conform').format({ async = true, lsp_format = 'fallback' }) end,
        desc = 'Format'
      },
    },
  },
}
