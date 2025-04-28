return {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    lazy = false,
    dependencies = {
        --   -- Automatically install LSPs and related tools to stdpath for Neovim
        'williamboman/mason.nvim', -- NOTE: Must be loaded before dependants
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
    config = function(_, _)
        -- local servers = lspconfig.util.available_servers()
        local lspconfig = require 'lspconfig'
        local mason_registry = require 'mason-registry'

        for _, package in ipairs(mason_registry.get_installed_packages()) do
            if package.spec.categories[1] == 'LSP' and package.name ~= 'jdtls' then
                local lsp_opts = require('os.handlers').load_lsp(package.name)

                if lspconfig[package.name] then
                    if lsp_opts then
                        -- vim.notify(vim.inspect(lsp_opts))
                        lspconfig[lsp_opts.name_server].setup(lsp_opts.setup_config)
                    end
                else
                    vim.notify('No lspconfig for ' .. package.name, vim.log.levels.WARN)
                end
                -- vim.notify(vim.inspect(require('os.handlers').load_lsp(package.name)))
                -- require('lspconfig')[package.name].setup(require('os.handlers').load_lsp(package.name))
            end
        end
    end,
}
