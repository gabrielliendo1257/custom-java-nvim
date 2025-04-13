return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  lazy = false,
  dependencies = {
    --   -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    --   'williamboman/mason-lspconfig.nvim',
    --   'WhoIsSethDaniel/mason-tool-installer.nvim',
    --
    --   -- Useful status updates for LSP.
    --   -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    --   { 'j-hui/fidget.nvim', opts = {} },
    --
    --   -- Allows extra capabilities provided by nvim-cmp
    -- 'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/nvim-cmp',
  },
  keys = require 'custom.plugins.keys.lsp-keys',
  config = function(plugin, opts)
    require 'custom.plugins.config.lsp-config'
  end,
}
