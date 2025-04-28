local M = {}

local core_utils = require 'core.utils'

M.initializer = function()
    require 'core.options'
    core_utils.load_mappings()
end

return M
