-- nvim-treesitter is on the `main` branch (the rewrite).
-- Parsers are installed via install(), and highlighting must be started per-buffer with vim.treesitter.start().
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  -- Provides @function.outer / @class.outer textobject queries used by mini.ai.
  dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install({
      'lua',
      'bash',
      'c',
      'cpp',
      'rust',
      'python',
      'json',
      'meson',
      'vim',
      'csv',
      'toml',
      'markdown',
      'markdown_inline',
      'vimdoc',
      'yaml',
    })

    -- Start treesitter highlighting for any buffer whose filetype has an
    -- installed parser. pcall makes this a no-op for filetypes without one.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(ev)
        if pcall(vim.treesitter.start, ev.buf) then
          -- Experimental treesitter indentation (replaces the old indent = { enable = true }). Drop this line if indenting misbehaves.
          vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })
  end,
}
