---@type table
local M = {}

local mason_registry = require 'mason-registry'
local jdtls = mason_registry.get_package 'jdtls'
local jdtls_path = jdtls:get_install_path()

---@return { launcher: string, config: string, lombok: string }
M.get_jdtls = function()
    local jdtls_os = require 'os.jdtls-os'

    ---@type string
    local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')

    ---@type string
    local config = jdtls_os.get_path_config_system()

    ---@type string
    local lombok = jdtls_path .. '/lombok.jar'

    return { launcher = launcher, config = config, lombok = lombok }
end

M.get_bundles = function()
    local java_debug_path = jdtls_path .. '/../java-debug-adapter'

    local bundles = {
        vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', 1),
    }

    -- local java_test = mason_registry.get_package 'java-test'
    local java_test_path = jdtls_path .. '/../java-test'
    vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. '/extension/server/*.jar', 1), '\n'))

    return bundles
end

M.get_workspace = function()
    local home = os.getenv 'HOME' or os.getenv 'HOMEPATH'
    local workspace_path = home .. '/code/workspace/'
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
    local workspace_dir = workspace_path .. project_name

    return workspace_dir
end

return M
