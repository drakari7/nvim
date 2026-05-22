return {
  'saghen/blink.cmp',
  version = '*',
  opts = {
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      per_filetype = {
        lua = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      },
      providers = {
        buffer = { min_keyword_length = 2 },
        lsp    = { min_keyword_length = 2 },
        lazydev = { name = 'LazyDev', module = 'lazydev.integrations.blink' },
      },
    },
    keymap = {
      preset = 'none', -- no defaults; we set everything explicitly
      ['<C-u>']  = { 'scroll_documentation_up', 'fallback' },
      ['<C-d>']  = { 'scroll_documentation_down', 'fallback' },
      ['<M-j>']  = { 'select_next', 'fallback' },
      ['<M-k>']  = { 'select_prev', 'fallback' },
      ['<M-CR>'] = { 'select_and_accept', 'fallback' },
      ['<C-Space>'] = { 'show_documentation', 'hide_documentation' }, -- toggle doc popup
    },
    snippets = { preset = 'default' }, -- uses vim.snippet (your <C-J>/<C-K> bindings still work)
    signature = { enabled = true },
    completion = {
      list = { selection = { preselect = false } },
      menu = {
        border = 'rounded',
        draw = {
          treesitter = { 'lsp' }, -- syntax-highlight LSP item labels via treesitter
          columns = {
            { 'kind_icon', 'label', gap = 1 },
            { 'source_name' }, -- the "[LSP]"/"[Buf]" equivalent column
          },
          components = {
            source_name = {
              highlight = function(ctx)
                return ({
                  LSP      = 'GruvboxPurple',
                  Buffer   = 'GruvboxAqua',
                  Path     = 'GruvboxBlue',
                  Snippets = 'GruvboxOrange',
                })[ctx.source_name] or 'GruvboxYellow'
              end,
            },
          },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = 'rounded' },
      },
      accept = {
        auto_brackets = { enabled = true },
        create_undo_point = true, -- `u` undoes just the accept, not the whole insert
      },
    },
    cmdline = {
      keymap = {
        preset = 'none',
        ['<M-j>']  = { 'select_next', 'fallback' },
        ['<M-k>']  = { 'select_prev', 'fallback' },
        ['<M-CR>'] = { 'select_and_accept', 'fallback' },
      },
      completion = { menu = { auto_show = true } },
    },
  },
}
