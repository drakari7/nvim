local function in_git_repo()
  vim.fn.system('git rev-parse --is-inside-work-tree')
  return vim.v.shell_error == 0
end
local has_glab = vim.fn.executable('glab') == 1
local glab_ok = function() return has_glab and in_git_repo() end

local function open_glab_page(suffix)
  return function()
    local remote = vim.fn.system('git remote get-url origin 2>/dev/null'):gsub('%s+$', '')
    local url
    if remote:match('^git@') then
      local host, path = remote:match('^git@([^:]+):(.+)%.git$')
      if host and path then url = 'https://' .. host .. '/' .. path end
    elseif remote:match('^https://') then
      url = (remote:gsub('%.git$', ''))
    end
    if url then vim.ui.open(url .. suffix) end
  end
end

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
        { pane = 1, icon = '󰈔', key = 'e',   desc = 'New file',       action = ':enew',                            indent = 2 },
        { pane = 1, icon = '󰎚', key = 'ni',  desc = 'Notes',          action = ':e ~/notes/notes.md',              indent = 2 },
        { pane = 1, icon = '󰈙', key = 'al',  desc = 'Aliases',        action = ':e ~/.config/zsh/aliasrc',         indent = 2 },
        { pane = 1, icon = '󰆍', key = 'zrc', desc = 'Zshrc',          action = ':e ~/.config/zsh/.zshrc',          indent = 2 },
        { pane = 1, icon = '󰌋', key = 'ss',  desc = 'SSH config',     action = ':e ~/.ssh/config',                 indent = 2 },
        { pane = 1, icon = '󰊢', key = 'gc',  desc = 'Git config',     action = ':e ~/.gitconfig',                  indent = 2 },
        { pane = 1, icon = '󰍹', key = 'wc',  desc = 'Wezterm config', action = ':e ~/.config/wezterm/wezterm.lua', indent = 2 },
        { pane = 1, icon = '󰌠', key = 'tp',  desc = 'test.py',        action = ':e ~/random/test.py',              indent = 2 },
        { pane = 1, icon = '󰆍', key = 'tb',  desc = 'test.sh',        action = ':e ~/random/test.sh',              indent = 2 },
        { pane = 1, icon = '󰗼', key = 'q',   desc = 'Quit',           action = ':qa',                              indent = 2 },
        { pane = 1, section = 'startup' },

        -- Pane 2 (right): GitLab, gated on glab + in-repo
        { pane = 2, icon = '󰗧', title = 'My MRs',        key = 'M', action = open_glab_page('/-/merge_requests?assignee_username=@me'), padding = 1, indent = 3, enabled = glab_ok },
        { pane = 2, section = 'terminal', cmd = 'glab mr list --assignee=@me -P 5', height = 7, padding = 1, ttl = 5 * 60, indent = 3, enabled = glab_ok },

        { pane = 2, icon = '󰈈', title = 'MRs to Review', key = 'R', action = open_glab_page('/-/merge_requests?state=opened'), padding = 1, indent = 3, enabled = glab_ok },
        { pane = 2, section = 'terminal', cmd = 'glab mr list --reviewer=@me -P 5', height = 7, padding = 1, ttl = 5 * 60, indent = 3, enabled = glab_ok },

        { pane = 2, icon = '󰊢', title = 'Open MRs',      key = 'P', action = open_glab_page('/-/merge_requests'), padding = 1, indent = 3, enabled = glab_ok },
        { pane = 2, section = 'terminal', cmd = 'glab mr list -P 5', height = 7, padding = 1, ttl = 5 * 60, indent = 3, enabled = glab_ok },

        -- TODO: Jira section — via Jira MCP or a `jira` CLI (e.g. `jira issue list --assignee=@me`).
        -- Useful but not essential; revisit when needed.
      },
    },
  },
}
