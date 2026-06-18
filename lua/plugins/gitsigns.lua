local map = require('confs.utils').map


return {
  'lewis6991/gitsigns.nvim',
  config = function()
    local gs = require('gitsigns')
    gs.setup({
      signs = {
        add          = { text = '+' },
        change       = { text = '~' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        -- Navigation
        map('n', ']h', function()
          if vim.wo.diff then
            vim.cmd.normal({ ']h', bang = true })
          else
            gs.nav_hunk('next')
          end
        end, "Next hunk")

        map('n', '[h', function()
          if vim.wo.diff then
            vim.cmd.normal({ '[h', bang = true })
          else
            gs.nav_hunk('prev')
          end
        end, "Prev hunk")

        -- Actions
        map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
        map('n', '<leader>hS', gs.stage_buffer, 'Stage buffer')
        map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
        map('n', '<leader>hR', gs.reset_buffer, 'Reset buffer')
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Stage hunk')
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Reset hunk')

        map('n', '<leader>hp', gs.preview_hunk, 'Preview hunk')
        map('n', '<leader>hb', gs.blame, 'Git blame')
        map('n', '<leader>tb', gs.toggle_current_line_blame, 'Toggle linewise git blame')
        map('n', '<leader>hd', gs.diffthis, 'Diff this')
        map('n', '<leader>hD', function() gs.diffthis('~') end, 'Diff this against last commit')
        map('n', '<leader>hq', gs.setqflist, 'Populate hunks in qlist')

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    })

    -- Shim until merged upstream: add `e` to the blame popup to show the commit
    -- in the current window ('edit' mode) instead of a vsplit (s) / tab (S).
    -- Avoids the orphaned [No Name] buffer that the tab variant leaves behind.
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'gitsigns-blame',
      callback = function(ev)
        vim.keymap.set('n', 'e', function()
          local cache = require('gitsigns.cache').cache
          local cursor = vim.api.nvim_win_get_cursor(0)[1]
          -- find the file buffer/window this blame panel is attached to
          local file_buf, file_win
          for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            local b = vim.api.nvim_win_get_buf(w)
            if cache[b] and cache[b].blame then
              file_buf, file_win = b, w
              break
            end
          end
          local entry = file_buf and cache[file_buf].blame.entries[cursor]
          if not entry then return end
          vim.api.nvim_set_current_win(file_win)
          require('gitsigns.async').run(
            require('gitsigns.actions.show_commit'),
            entry.commit.sha, 'edit', file_buf)
        end, { buffer = ev.buf, desc = 'Show commit in current window' })
      end,
    })
  end
}
