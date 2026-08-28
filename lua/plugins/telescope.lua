return {
  'nvim-telescope/telescope.nvim',
  lazy = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    'jvgrootveld/telescope-zoxide',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  keys = function()
    local builtin = require('telescope.builtin')
    local utils = require('confs.utils')

    local function find_in_dir(dir, title)
      return function()
        builtin.find_files({ cwd = dir, prompt_title = title })
      end
    end

    local function find_files_from_git_root()
      local opts = utils.is_git_repo() and { cwd = utils.get_git_root() } or {}
      builtin.find_files(opts)
    end

    local function live_grep_from_git_root()
      local opts = { path_display = { 'tail' }, disable_coordinates = true }
      if utils.is_git_repo() then
        opts = vim.tbl_extend('keep', opts, { cwd = utils.get_git_root() })
      end
      builtin.live_grep(opts)
    end

    return {
      { '<leader>ft', builtin.builtin,                   desc = 'Telescope Pickers' },
      { '<leader>ff', find_files_from_git_root,          desc = 'Find files' },
      { '<leader>fg', live_grep_from_git_root,           desc = 'Live grep' },
      { '<leader>fb', builtin.buffers,                   desc = 'Buffers' },
      { '<leader>fh', builtin.help_tags,                 desc = 'Help tags' },
      { '<leader>fl', builtin.lsp_document_symbols,      desc = 'Document Symbols [LSP]' },
      { '<leader>fo', builtin.vim_options,               desc = 'Vim options' },
      { '<leader>fc', builtin.current_buffer_fuzzy_find, desc = 'Current buffer search' },
      { '<leader>gc', builtin.git_commits,               desc = 'Git commits' },

      { '<leader>fv', find_in_dir('~/.config/nvim', 'Nvim Config Files'), desc = 'Nvim config directory' },
      { '<leader>fs', find_in_dir('~/scripts', 'My Scripts'),             desc = 'Scripts directory' },

      { '<leader>fw', function() builtin.grep_string({ initial_mode = 'normal' }) end,                       desc = 'Grep word under cursor' },
      { '<leader>fw', mode = 'x', function()
        local m = vim.fn.mode()
        local lines = vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.'), { type = m })
        builtin.grep_string({ search = table.concat(lines, '\n'), initial_mode = 'normal' })
      end, desc = 'Grep visual selection' },
      { '<leader>fr', function() builtin.resume({ initial_mode = 'normal' }) end,                            desc = 'Resume last picker' },
      { '<leader>cs', function() builtin.colorscheme({ ignore_builtins = true, enable_preview = true }) end, desc = 'Change colorscheme' },
      -- zoxide extension is set up in config(); defer require to call time so it's available.
      { '<leader>ji', function() require('telescope').extensions.zoxide.list() end, desc = 'Zoxide cd' },
    }
  end,
  config = function()
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')

    -- <CR> opens every multi-selected entry; falls back to the default action
    -- when nothing is marked, so non-file pickers keep working.
    local function select_multi(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()
      if #multi == 0 then
        return actions.select_default(prompt_bufnr)
      end
      actions.close(prompt_bufnr)
      for _, entry in ipairs(multi) do
        local path = entry.path or entry.filename or entry.value
        vim.cmd.edit(vim.fn.fnameescape(path))
        if entry.lnum then
          vim.api.nvim_win_set_cursor(0, { entry.lnum, (entry.col or 1) - 1 })
        end
      end
    end

    require('telescope').setup({
      defaults = {
        prompt_prefix = "",
        results_title = false,
        layout_strategy = 'horizontal',
        layout_config = {
          width = 0.9,
          preview_width = 0.47,
        },

        file_ignore_patterns = { "__pycache__/", "^%.git/", "/%.git/" },
        mappings = {
          i = {
            ["<m-j>"] = actions.move_selection_next,
            ["<m-k>"] = actions.move_selection_previous,
            ["<CR>"] = select_multi,
          },
          n = {
            ["<CR>"] = select_multi,
          },
        },

        -- --smart-case, --hidden and the prune globs come from
        -- $RIPGREP_CONFIG_PATH (~/.config/zsh/ripgreprc).
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
        }
      },

      pickers = {
        find_files = {
          -- Explicit so it's obvious $RIPGREP_CONFIG_PATH applies here; telescope's
          -- implicit default happens to pick rg first, but silently.
          find_command = { "rg", "--files", "--color", "never" },
          no_ignore = false, -- keep respecting .gitignore
        },
      },

      extensions = {
        zoxide = {
          mappings = {
            ["<C-g>"] = {
              keepinsert = true,
              action = function(selection)
                require('telescope.builtin').live_grep({
                  cwd = selection.path,
                  path_display = { 'tail' },
                  disable_coordinates = true,
                })
              end
            }
          }
        }
      }
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('zoxide')
  end
}
