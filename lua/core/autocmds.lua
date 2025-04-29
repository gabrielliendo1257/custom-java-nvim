vim.api.nvim_create_augroup('jdtls_lsp', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
    group = 'jdtls_lsp',
    pattern = 'java',
    callback = function()
        local jdtls_config = require('custom.plugins.lsp.server.jdtls-ls').config

        vim.list_extend(jdtls_config.init_options.bundles, require('spring_boot').java_extensions())
        print(vim.inspect(jdtls_config.init_options.bundles))
        require('jdtls').start_or_attach(jdtls_config)
    end,
})
