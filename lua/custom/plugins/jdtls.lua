return {
  'mfussenegger/nvim-jdtls',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  main = 'jdtls',
  init = function(plugin)
    --     vim.cmd [[
    --     augroup jdtls_lsp
    --         autocmd!
    --         autocmd FileType java lua require(plugin.main).start_or_attach(plugin.opts)
    --     augroup end
    -- ]]
    local jdtls_config = require 'custom.plugins.config.jdtls'

    local config = {
      cmd = jdtls_config.cmd,
      root_dir = jdtls_config.root_dir,
      settings = jdtls_config.settings,
      capabilities = jdtls_config.capabilities,
      init_options = jdtls_config.init_options,
      on_attach = jdtls_config.on_attach,
    }
    vim.list_extend(jdtls_config.init_options.bundles, require('spring_boot').java_extensions())

    vim.api.nvim_create_augroup('jdtls_lsp', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = 'jdtls_lsp',
      pattern = 'java',
      callback = function()
        require(plugin.main).start_or_attach(config)
      end,
    })
  end,
  keys = require 'custom.plugins.keys.jdtls_keys',
  config = function(_, opts)
    return opts
  end,
}
