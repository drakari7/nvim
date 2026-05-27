-- Set leader
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

-- Basic options
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"

-- Floating window border
vim.o.winborder = 'rounded'

-- Wrap
vim.opt.wrap = false
vim.opt.whichwrap = ""
vim.opt.breakindent = true
vim.opt.linebreak = true
vim.opt.showbreak = "  > "

-- Format options
vim.opt.formatoptions = "c,r,j,q,n"

-- Tabs and indentation
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- File format
vim.opt.fileformats = {'unix'}
vim.opt.fileencoding = "utf-8"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Popup menu options
vim.opt.pumheight = 15
vim.opt.completeopt = { "menu", "menuone", "noselect", "preview" }

-- Scrolloff and splits
vim.opt.scrolloff = 20
vim.opt.sidescrolloff = 20
vim.opt.splitbelow = true
vim.opt.splitright = true

-- List chars
vim.opt.list = true
vim.opt.listchars = {
  -- eol='¬',   -- comment out to make it easier to copy from terminal
  tab='»·',
  trail='·',
  extends='<',
  precedes='>',
  conceal='┊',
  nbsp='␣',
}

-- Clipboard
-- If ssh is detected, use osc52 for clipboard reads (paste not supported by wezterm)
if os.getenv('SSH_TTY') then
  local function default_paste()
    return {
      vim.fn.split(vim.fn.getreg(''), '\n'),
      vim.fn.getregtype(''),
    }
  end

  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = default_paste,
      ['*'] = default_paste,
    },
  }
end
