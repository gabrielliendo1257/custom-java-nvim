return {
  {
    '<leader>gc',
    '<cmd>Neogit cwd=' .. vim.fn.getcwd() .. '<cr>',
    desc = '[G]it add files.',
    mode = 'n',
    silent = true,
  },
  {
    '<leader>gp',
    '<cmd>Neogit push<cr>',
    desc = '[G]it push.',
    mode = 'n',
    silent = true,
  },
}
