return {
  'akinsho/bufferline.nvim',
  lazy = false,
  opts = {
    options = {
      hover = {
        enabled = true,
        delay = 200,
        reveal = { 'close' },
      },
    },
  },
  keys = {
    { '<TAB>', '<cmd>BufferLineCycleNext<cr>', desc = '[B]ufferLine Next', mode = 'n', silent = true },
    { '<S-TAB>', '<cmd>BufferLineCyclePrev<cr>', desc = '[B]ufferLine Prev', mode = 'n', silent = true },
    { '<C-d>', '<cmd>BufferLineCloseOthers<cr>', desc = '[B]ufferLine Prev', mode = 'n', silent = true },
  },
  main = 'bufferline',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
}
