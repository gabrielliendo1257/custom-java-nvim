local M = {}

local lsp_config = require 'custom.plugins.config.lsp-config'
local util = lsp_config.util
local capabilities = lsp_config.capabilities
local lua_root_files = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
}

M.setup = {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    -- Depending on the usage, you might want to add additional paths here.
                    -- "${3rd}/luv/library"
                    -- "${3rd}/busted/library",
                },
                -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
                -- library = vim.api.nvim_get_runtime_file("", true)
            },
        })
    end,

    filetypes = { 'lua' },
    root_dir = function(fname)
        local root = util.root_pattern(unpack(lua_root_files))(fname)
        if root and root ~= vim.env.HOME then
            return root
        end
        local root_lua = util.root_pattern 'lua/' (fname) or ''
        local root_git = util.find_git_ancestor(fname) or ''
        if root_lua == '' and root_git == '' then
            return
        end
        return #root_lua >= #root_git and root_lua or root_git
    end,
    single_file_support = true,
    log_level = vim.lsp.protocol.MessageType.Warning,

    -- on_attach = on_attach,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = {
                    [vim.fn.expand '$VIMRUNTIME/lua'] = true,
                    [vim.fn.expand '$VIMRUNTIME/lua/vim/lsp'] = true,
                    [vim.fn.stdpath 'data' .. '/lazy/ui/nvchad_types'] = true,
                    [vim.fn.stdpath 'data' .. '/lazy/lazy.nvim/lua/lazy'] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
}

return M
