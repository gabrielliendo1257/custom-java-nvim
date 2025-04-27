return {
  {
    'javiorfo/nvim-springtime',
    lazy = true,
    cmd = { 'Springtime', 'SpringtimeUpdate' },
    dependencies = {
      'javiorfo/nvim-popcorn',
      'javiorfo/nvim-spinetta',
      'hrsh7th/nvim-cmp',
    },
    build = function()
      require('springtime.core').update()
    end,
    opts = {
      spring = {
        project = {
          selected = 1,
        },
        language = {
          selected = 1,
        },
        packaging = {
          selected = 1,
        },
        project_metadata = {
          group = 'com.example',
          artifact = 'demo',
          name = 'demo',
          package_name = 'com.example.demo',
          version = '0.0.1-SNAPSHOT',
        },
      },

      -- Some popup options
      dialog = {
        selection_keymap = '<C-Space>',
        generate_keymap = 'gs',
        confirmation = true,
        style = {
          title_link = 'Boolean',
          section_link = 'Type',
        },
      },

      workspace = {
        path = vim.fn.expand '%:p:h',

        decompress = true,
        open_auto = true,
      },
      internal = {
        log_debug = false,
      },
    },
  },
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
