local lualine_config = require("mini.plugins.config.lualine-config")

return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	main = "lualine",
	opts = {
		options = {
			icons_enabled = true,
			theme = lualine_config.theme,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
		},
		sections = {
			lualine_a = {
				lualine_config.modes,
			},
			lualine_b = {
				lualine_config.space,
			},
			lualine_c = {
				-- lualine_config.filename,
				-- lualine_config.filetype,
				-- lualine_config.space,
				-- lualine_config.branch,
				-- lualine_config.diff,
				-- lualine_config.space,
			},
			lualine_x = {
				-- lualine_config.space,
			},
			lualine_y = { lualine_config.macro, lualine_config.space },
			lualine_z = {
				lualine_config.dia,
				lualine_config.lsp,
				lualine_config.cwd,
			},
			-- inactive_sections = {
			--   lualine_a = {},
			--   lualine_b = {},
			--   lualine_c = { 'filename' },
			--   lualine_x = { 'location' },
			--   lualine_y = {},
			--   lualine_z = {},
			-- },
		},
	},
}
