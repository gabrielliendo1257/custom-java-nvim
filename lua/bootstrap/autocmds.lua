-- Setup our JDTLS server any time we open up a java file
vim.cmd [[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require'custom.plugins.config.jdtls'.setup_jdtls()
    augroup end
]]
