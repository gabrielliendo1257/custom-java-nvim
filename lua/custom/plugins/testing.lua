return {
    {
        'JavaHello/spring-boot.nvim',
        ft = { 'java', 'yaml', 'jproperties' },
        dependencies = {
            'mfussenegger/nvim-jdtls', -- or nvim-java, nvim-lspconfig
            {
                'ibhagwan/fzf-lua',
                dependencies = { 'echasnovski/mini.icons' },
                opts = {},
            },
        },
        opts = {},
    },
}
