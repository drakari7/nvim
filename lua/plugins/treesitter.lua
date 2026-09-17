-- nvim-treesitter is on the `main` branch (the rewrite).
-- Parsers are installed via install(), and highlighting must be started per-buffer with vim.treesitter.start().
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  -- Provides @function.outer / @class.outer queries (mini.ai) and the move module (]f / [f).
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

    local move = require('nvim-treesitter-textobjects.move')
    local function map_move(lhs, fn, desc)
      vim.keymap.set({ 'n', 'x', 'o' }, lhs, function() fn('@function.outer', 'textobjects') end, { desc = desc })
    end
    map_move(']f', move.goto_next_start, 'Next function start')
    map_move('[f', move.goto_previous_start, 'Previous function start')
    map_move(']F', move.goto_next_end, 'Next function end')
    map_move('[F', move.goto_previous_end, 'Previous function end')
  end,
}
