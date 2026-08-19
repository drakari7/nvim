return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    { '<leader>nn', function() require('snacks').explorer() end, desc = 'File tree' },
  },
  opts = {
    bigfile     = { enabled = true },
    indent      = { enabled = true },
    notifier    = { enabled = true },
    picker      = { enabled = true },
    explorer    = { enabled = true },
    -- statuscolumn= { enabled = true },
    -- terminal    = { enabled = true },
    -- words       = { enabled = true },
    -- scope       = { enabled = true },
    dashboard   = {
      enabled = true,
      sections = {
        -- Pane 1 (left): header, bookmarks, startup
        { pane = 1, section = 'header' },
        { pane = 1, title = 'Bookmarks', indent = 2 },
        { pane = 1, icon = '󰈔', key = 'e',   desc = 'New file',       action = ':enew',                             indent = 2 },
        { pane = 1, icon = '󰎚', key = 'ni',  desc = 'Notes',          action = ':e ~/notes/notes.md',               indent = 2 },
        { pane = 1, icon = '󰈙', key = 'al',  desc = 'Aliases',        action = ':e ~/.config/zsh/aliasrc',          indent = 2 },
        { pane = 1, icon = '󰆍', key = 'zrc', desc = 'Zshrc',          action = ':e ~/.config/zsh/.zshrc',           indent = 2 },
        { pane = 1, icon = '󰌋', key = 'ss',  desc = 'SSH config',     action = ':e ~/.ssh/config',                  indent = 2 },
        { pane = 1, icon = '󰊢', key = 'gc',  desc = 'Git config',     action = ':e ~/.gitconfig',                   indent = 2 },
        { pane = 1, icon = '󰍹', key = 'wc',  desc = 'Wezterm config', action = ':e ~/.config/wezterm/wezterm.lua',  indent = 2 },
        { pane = 1, icon = '󰌠', key = 'tp',  desc = 'test.py',        action = ':e ~/random/test.py',               indent = 2 },
        { pane = 1, icon = '󰆍', key = 'tb',  desc = 'test.sh',        action = ':e ~/random/test.sh',               indent = 2 },
        { pane = 1, icon = '󱘗', key = 'tr',  desc = 'test.rs',        action = ':e ~/random/test_rust/src/main.rs', indent = 2 },
        { pane = 1, icon = '󰗼', key = 'q',   desc = 'Quit',           action = ':qa',                               indent = 2 },
        { pane = 1, section = 'startup' },

        -- TODO: Jira section — via Jira MCP or a `jira` CLI (e.g. `jira issue list --assignee=@me`).
        -- Useful but not essential; revisit when needed.
      },
    },
  },
}
