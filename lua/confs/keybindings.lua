local map = require('confs.utils').map
local silent_opt = { silent = true }

-- Smoother scrolling
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Useful mappings
map('n', '<leader>qh', '<cmd>noh<CR>', 'Quiet highlight', silent_opt)
map('n', '<leader>nw', '<cmd>set wrap!<CR>', 'Toggle wrap', silent_opt)
map('n', '<leader>hi', vim.show_pos, 'Inspect under cursor')
map('n', '<leader>sw', '<cmd>% s#\\s\\+$##e<CR>:w<CR>', 'Strip trailing whitespace')
map('n', '<leader>sm', ':%s/\\r//g<CR>', 'Strip carriage returns')
map('n', '<leader>cd', '<cmd>cd %:p:h<CR>', 'cd to current file dir')
map('n', '<leader>tc', '<cmd>tabclose<CR>', 'Tab Close')

-- Quickfix and loclist
map('n', '<leader>lc', '<cmd>lclose<CR>', 'Close loclist')
map('n', '<leader>qc', '<cmd>cclose<CR>', 'Close quickfixlist')

-- Visual mode
map('v', '<leader>ct', ':!column -t<CR>gv>', 'Column table')
map('v', 'K', ":m '<-2<CR>gv=gv", 'Move line up', silent_opt)
map('v', 'J', ":m '>+1<CR>gv=gv", 'Move line down', silent_opt)

-- Json and python conversions
map('n', '<leader>js', ":s/'/\"/ge | s/False/false/ge | s/True/true/ge | s/None/null/ge<CR>", "Convert to json")
map('v', '<leader>js', ":g/^/ s#'#\"#ge | s#False#false#ge | s#True#true#ge | s#None#null#ge<CR>", "Convert to json")
map('v', '<leader>jp', ":g/^/ s#\"#'#ge | s#false#False#ge | s#true#True#ge | s#null#None#ge<CR>", "Convert json to python")

-- Misc
map({ 'n', 'v' }, '<leader>bh', '"_d', 'Blackhole register')
map({ 'n', 'i' }, '<F1>', '<NOP>', 'Unmap F1')
map('n', '<leader>hw', ":let @/='\\<<C-R><C-W>\\>'<CR>:set hls<CR>", 'Highlight word under cursor')
map('n', '<leader>va', 'ggVG', 'Visual select entire file')
map('n', '<leader>ex', ':w<CR>:! chmod +x %<CR>', 'Make current file executable')
map('n', '<leader>ni', ':e ~/notes/notes.md<CR>', 'Open notes')


-- Snippet navigation
map({ 'i', 's' }, '<C-J>', function()
  if vim.snippet.active({ direction = 1 }) then
    return vim.snippet.jump(1)
  end
end, "Jump to next snippet placeholder")

map({ 'i', 's' }, '<C-K>', function()
  if vim.snippet.active({ direction = -1 }) then
    return vim.snippet.jump(-1)
  end
end, "Jump to prev snippet placeholder")
