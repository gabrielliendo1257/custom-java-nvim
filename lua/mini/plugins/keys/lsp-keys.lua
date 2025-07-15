return {
    -- Rename the variable under your cursor.
    --  Most Language Servers support renaming across files, etc.
    { '<leader>cr', vim.lsp.buf.rename,                                         desc = '[R]e[n]ame',              mode = 'n', silent = true },
    { '<leader>cF', vim.diagnostic.open_float,                                  desc = '[D]iagnostic float',      mode = 'n', silent = true },

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    { '<leader>ca', vim.lsp.buf.code_action,                                    desc = '[C]ode [A]ction',         mode = 'n', silent = true },

    -- WARN: This is not Goto Definition, this is Goto Declaration.
    --  For example, in C this would take you to the header.
    { '<leader>cD', vim.lsp.buf.declaration,                                    desc = '[G]oto [D]eclaration',    mode = 'n', silent = true },
}
