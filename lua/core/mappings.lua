local M = {}

M.general = {
    i = {
        -- navigate within insert mode
        ['<C-h>'] = { '<Left>', 'Move left' },
        ['<C-l>'] = { '<Right>', 'Move right' },
        ['<C-j>'] = { '<Down>', 'Move down' },
        ['<C-k>'] = { '<Up>', 'Move up' },
    },

    n = {
        -- switch between windows
        ['<C-h>'] = { '<C-w>h', 'Window left' },
        ['<C-l>'] = { '<C-w>l', 'Window right' },
        ['<C-j>'] = { '<C-w>j', 'Window down' },
        ['<C-k>'] = { '<C-w>k', 'Window up' },
        ['<leader>q'] = { '<cmd>q<cr>', 'Window up' },

        -- save
        ['<C-s>'] = { '<cmd> w <CR>', 'Save file' },
        ['<Esc>'] = { '<cmd>nohlsearch<CR>' },
    },

    t = {
        ['<C-x>'] = { vim.api.nvim_replace_termcodes('<C-\\><C-N>', true, true, true), 'Escape terminal mode' },
        ['<Esc><Esc>'] = { '<C-\\><C-n>', 'Exit terminal mode' },
    },
}

return M
