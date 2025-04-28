return {
    'mfussenegger/nvim-jdtls',
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    main = 'jdtls',
    init = function(plugin)
        -- local handler = require('os.handlers').load_lsp 'jdtls'
        --
        -- vim.list_extend(handler.init_options.bundles, require('spring_boot').java_extensions())
        -- print(vim.inspect(handler.init_options.bundles))
        --
        -- vim.api.nvim_create_augroup('jdtls_lsp', { clear = true })
        -- vim.api.nvim_create_autocmd('FileType', {
        --     group = 'jdtls_lsp',
        --     pattern = 'java',
        --     callback = function()
        --         require(plugin.main).start_or_attach(handler)
        --     end,
        -- })
    end,
    keys = require 'custom.plugins.keys.jdtls_keys',
    config = function(_, opts)
        return opts
    end,
}
