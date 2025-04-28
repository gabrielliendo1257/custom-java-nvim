return { -- Autocompletion
    'hrsh7th/nvim-cmp',
    lazy = false,
    event = 'InsertEnter',
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
            'L3MON4D3/LuaSnip',
            build = (function()
                -- Build Step is needed for regex support in snippets.
                -- This step is not supported in many windows environments.
                -- Remove the below condition to re-enable on windows.
                if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
                    return
                end
                return 'make install_jsregexp'
            end)(),
        },
        'saadparwaiz1/cmp_luasnip',
        -- Adds other completion capabilities.
        --  nvim-cmp does not ship with all sources by default. They are split
        --  into multiple repos for maintenance purposes.
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-path',
    },
    main = 'cmp',
    opts = function(plugin, opts)
        -- See `:help cmp`
        local cmp = require(plugin.main)
        local luasnip = require 'luasnip'
        local new_kind_icon = require 'ui'

        opts = {
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = { completeopt = 'menu,menuone,noinsert' },
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<CR>'] = cmp.mapping.confirm { select = true },
                ['<C-Space>'] = cmp.mapping.complete {},
                ['<C-l>'] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { 'i', 's' }),
                ['<C-h>'] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { 'i', 's' }),

                -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
                --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
            },
            formatting = {
                fields = { 'kind', 'abbr', 'menu' },
                format = function(entry, vim_item)
                    -- Kind icons
                    -- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
                    vim_item.kind = string.format('%s', new_kind_icon.kind[vim_item.kind])
                    -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
                    vim_item.menu = ({
                        nvim_lsp = '(LSP)',
                        luasnip = '(Snippet)',
                        buffer = '(Buffer)',
                        path = '(Path)',
                    })[entry.source.name]
                    return vim_item
                end,
            },
            sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'buffer' },
                { name = 'nvim_lua' },
                { name = 'path' },
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Replace,
                select = false,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
        }
        return opts
    end,
}
