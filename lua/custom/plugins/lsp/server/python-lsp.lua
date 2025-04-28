local M = {}

local lsp_common_config = require 'custom.plugins.config.lsp-config'

M.python_setup = {
    init = function(_, config)
        config.settings.python.analysis.stubPath = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy', 'python-type-stubs')
    end,
    capabilities = lsp_common_config.capabilities,
}

return M
