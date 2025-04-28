local M = {

    ['jdtls'] = { name_server = 'jdtls', setup_config = require('custom.plugins.lsp.server.jdtls-ls').config },

    ['lua-language-server'] = { name_server = 'lua_ls', setup_config = require('custom.plugins.lsp.server.lua-ls').setup },

    ['pyright'] = { name_server = 'pyright', setup_config = require('custom.plugins.lsp.server.python-lsp').python_setup },
}

return M
