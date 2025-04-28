local M = {}

local servers = require 'custom.plugins.lsp.server'

---@return table | nil
---@param lsp_name string
M.load_lsp = function(lsp_name)
    if servers[lsp_name] ~= nil then
        return servers[lsp_name]
    end

end

return M
