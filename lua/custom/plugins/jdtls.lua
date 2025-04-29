return {
    'mfussenegger/nvim-jdtls',
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    main = 'jdtls',
    init = function(plugin) end,
    keys = require 'custom.plugins.keys.jdtls_keys',
    config = function(_, opts)
        return opts
    end,
}
