local M = {}

local merge_tb = vim.tbl_deep_extend

M.load_config = require 'core.options'

M.load_mappings = function(section, mapping_opt)
    vim.schedule(function()
        local function set_section_map(section_values)
            -- section_values, tabla carga de keymaps de plugins
            -- vim.notify(vim.inspect(section_values))

            -- if section_values.plugin then
            --     return
            -- end

            -- section_values.plugin = nil

            for mode, mode_values in pairs(section_values) do
                local default_opts = merge_tb('force', { mode = mode, silent = true }, mapping_opt or {})

                -- keybind [<leader>cb], mapping_info { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" }
                for keybind, mapping_info in pairs(mode_values) do
                    -- merge default + user opts
                    local opts = merge_tb('force', default_opts, mapping_info.opts or {})

                    mapping_info.opts, opts.mode = nil, nil
                    opts.desc = mapping_info[2]

                    -- vim.notify(vim.inspect(opts))

                    vim.keymap.set(mode, keybind, mapping_info[1], opts)
                end
            end
        end

        local mappings = require 'core.mappings'
        -- vim.notify(vim.inspect(mappings))

        if type(section) == 'string' then
            mappings[section]['plugin'] = nil
            mappings = { mappings[section] }
        end

        for _, sect in pairs(mappings) do
            set_section_map(sect)
        end
    end)
end

M.is_windows = vim.loop.os_uname().sysname == 'Windows_NT'

M.is_linux = vim.loop.os_uname().sysname == 'Linux'

M.is_termux = vim.loop.os_uname().system == 'Linux' and vim.loop.os_uname().machine == 'aarch64'

-- local log_file_path = vim.fn.stdpath 'data' .. '/my_log.txt'
--
-- M.write_log = function(message)
--     local file = io.open(log_file_path, 'a') -- "a" = append mode
--     if file then
--         file:write(os.date '[%Y-%m-%d %H:%M:%S] ' .. message .. '\n')
--         file:close()
--     else
--         vim.notify('No se pudo abrir el archivo de log', vim.log.levels.ERROR)
--     end
-- end

return M
