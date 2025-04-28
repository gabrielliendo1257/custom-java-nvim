local M = {}

M.lspconfig = require 'lspconfig'
M.util = require 'lspconfig.util'

M.on_init = function(client, _)
    if client.supports_method 'textDocument/semanticTokens' then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem = {
    documentationFormat = { 'markdown', 'plaintext' },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
        properties = {
            'documentation',
            'detail',
            'additionalTextEdits',
        },
    },
}

-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- lspconfig.emmet_language_server.setup {}
--
-- lspconfig.html.setup {
--     capabilities = capabilities,
-- }
--
-- lspconfig.basedpyright.setup {
--     init = function(_, config)
--         config.settings.python.analysis.stubPath = vim.fs.joinpath(vim.fn.stdpath 'data', 'lazy', 'python-type-stubs')
--     end,
--     capabilities = capabilities,
-- }
--
--
-- lspconfig.lemminx.setup {
--     -- on_attach = on_attach,
--     capabilities = capabilities,
-- }
--
-- lspconfig.ts_ls.setup {
--     capabilities = capabilities,
-- }

return M
