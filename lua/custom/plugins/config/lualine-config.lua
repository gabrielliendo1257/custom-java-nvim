local M = {}

local palette = {
  bg = '#161617',
  fg = '#c9c7cd',
  subtext1 = '#b4b1ba',
  subtext2 = '#9f9ca6',
  subtext3 = '#8b8693',
  subtext4 = '#6c6874',
  bg_dark = '#131314',
  black = '#27272a',
  red = '#ea83a5',
  green = '#90b99f',
  yellow = '#e6b99d',
  purple = '#aca1cf',
  magenta = '#e29eca',
  orange = '#f5a191',
  blue = '#92a2d5',
  cyan = '#85b5ba',
  bright_black = '#353539',
  bright_red = '#ed96b3',
  bright_green = '#a7c8b3',
  bright_yellow = '#eac5ae',
  bright_purple = '#b7aed5',
  bright_magenta = '#e8b0d4',
  bright_orange = '#f6b0a2',
  bright_blue = '#a7b3dd',
  bright_cyan = '#97c0c4',
  gray0 = '#18181a',
  gray1 = '#1b1b1c',
  gray2 = '#2a2a2c',
  gray3 = '#313134',
  gray4 = '#3b3b3e',
  -- Special
  none = 'NONE',
}
local colors = palette

local modecolor = {
  n = colors.red,
  i = colors.cyan,
  v = colors.purple,
  [''] = colors.purple,
  V = colors.red,
  c = colors.yellow,
  no = colors.red,
  s = colors.yellow,
  S = colors.yellow,
  [''] = colors.yellow,
  ic = colors.yellow,
  R = colors.green,
  Rv = colors.purple,
  cv = colors.red,
  ce = colors.red,
  r = colors.cyan,
  rm = colors.cyan,
  ['r?'] = colors.cyan,
  ['!'] = colors.red,
  t = colors.bright_red,
}

local normal_icon = '  '

M.theme = {
  normal = {
    a = { fg = colors.bg_dark, bg = colors.blue },
    b = { fg = colors.blue, bg = colors.white },
    c = { fg = colors.white, bg = colors.bg_dark },
    z = { fg = colors.white, bg = colors.bg_dark },
  },
  insert = { a = { fg = colors.bg_dark, bg = colors.orange } },
  visual = { a = { fg = colors.bg_dark, bg = colors.green } },
  replace = { a = { fg = colors.bg_dark, bg = colors.green } },
}

M.space = {
  function()
    return ' '
  end,
  color = { bg = colors.bg_dark, fg = colors.blue },
}

M.filename = {
  'filename',
  color = { bg = colors.blue, fg = colors.bg, gui = 'bold' },
  separator = { left = '', right = '' },
}

M.filetype = {
  'filetype',
  icons_enabled = false,
  color = { bg = colors.gray2, fg = colors.blue, gui = 'italic,bold' },
  separator = { left = '', right = '' },
}

M.branch = {
  'branch',
  icon = '',
  color = { bg = colors.green, fg = colors.bg, gui = 'bold' },
  separator = { left = '', right = '' },
}

M.location = {
  'location',
  color = { bg = colors.yellow, fg = colors.bg, gui = 'bold' },
  separator = { left = '', right = '' },
}

M.diff = {
  'diff',
  color = { bg = colors.gray2, fg = colors.bg, gui = 'bold' },
  separator = { left = '', right = '' },
  symbols = { added = ' ', modified = ' ', removed = ' ' },

  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.yellow },
    removed = { fg = colors.red },
  },
}

M.modes = {
  'mode',
  icon = normal_icon,
  color = function()
    local mode_color = modecolor
    return { bg = mode_color[vim.fn.mode()], fg = colors.bg_dark, gui = 'bold' }
  end,
  separator = { left = '', right = '' },
}

local fn = vim.fn
local fnamemodify = fn.fnamemodify
local getcwd = fn.getcwd

M.cwd = {
  function()
    local dir_name = ' 󰉖 ' .. fnamemodify(getcwd(), ':t') .. ' '
    return (vim.o.columns > 85 and dir_name) or ''
  end,
  separator = { left = '' },
  color = { bg = colors.bg_dark, fg = colors.bright_yellow, gui = 'bold' },
}

local lsp_v = vim.lsp
local get_clients = lsp_v.get_clients

local api = vim.api
local win_get_buf = api.nvim_win_get_buf

M.lsp_status = function()
  if rawget(vim, 'lsp') then
    for _, client in ipairs(get_clients()) do
      if client.attached_buffers[win_get_buf(0)] then
        return (vim.o.columns > 100 and '   LSP ' .. client.name .. ' ') or '   LSP '
      end
    end
  end

  return ''
end

M.getLspName = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local buf_clients = vim.lsp.get_clients { bufnr = bufnr }
  local buf_ft = vim.bo.filetype
  if next(buf_clients) == nil then
    return '  No servers'
  end
  local buf_client_names = {}

  for _, client in pairs(buf_clients) do
    if client.name ~= 'null-ls' then
      table.insert(buf_client_names, client.name)
    end
  end

  local lint_s, lint = pcall(require, 'lint')
  if lint_s then
    for ft_k, ft_v in pairs(lint.linters_by_ft) do
      if type(ft_v) == 'table' then
        for _, linter in ipairs(ft_v) do
          if buf_ft == ft_k then
            table.insert(buf_client_names, linter)
          end
        end
      elseif type(ft_v) == 'string' then
        if buf_ft == ft_k then
          table.insert(buf_client_names, ft_v)
        end
      end
    end
  end

  local ok, conform = pcall(require, 'conform')
  local formatters = table.concat(conform.list_formatters_for_buffer(), ' ')
  if ok then
    for formatter in formatters:gmatch '%w+' do
      if formatter then
        table.insert(buf_client_names, formatter)
      end
    end
  end

  local hash = {}
  local unique_client_names = {}

  for _, v in ipairs(buf_client_names) do
    if not hash[v] then
      unique_client_names[#unique_client_names + 1] = v
      hash[v] = true
    end
  end
  local language_servers = table.concat(unique_client_names, ', ')

  return '  ' .. language_servers
end

M.macro = {
  require('noice').api.status.mode.get,
  cond = require('noice').api.status.mode.has,
  color = { fg = colors.red, bg = colors.bg_dark, gui = 'italic,bold' },
}

M.dia = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
  diagnostics_color = {
    error = { fg = colors.red },
    warn = { fg = colors.yellow },
    info = { fg = colors.purple },
    hint = { fg = colors.cyan },
  },
  color = { bg = colors.gray2, fg = colors.blue, gui = 'bold' },
  separator = { left = '' },
}

M.lsp = {
  function()
    return M.lsp_status()
  end,
  separator = { left = '', right = '' },
  color = { bg = colors.purple, fg = colors.bg, gui = 'italic,bold' },
}

return M
