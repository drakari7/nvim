return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  init = function()
    vim.g.rustaceanvim = {
      server = {
        cmd = function()
          local toolchain = vim.fn.trim(vim.fn.system("rustup which rust-analyzer"))
          return { toolchain }
        end,
        default_settings = {
          ['rust-analyzer'] = {
            cargo = { features = 'all' },
          },
        },
      },
    }
  end,
}
