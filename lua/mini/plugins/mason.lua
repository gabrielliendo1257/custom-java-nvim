return {
	{
		"mason-org/mason.nvim",
		lazy = false,
		dependencies = {
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				main = "mason-tool-installer",
				opts = {
					ensure_installed = {
						"prettier", -- prettier formatter
						"stylua", -- lua formatter
						-- 'isort', -- python formatter
						"black", -- python formatter
						"mypy", -- python linter
						"eslint_d", -- js linter
						"pyright",
						"lua-language-server",
						"java-test",
						"java-debug-adapter",
						"jdtls",
					},
				},
			},
		},
		main = "mason",
		config = true,
	},
	{
		"mason-org/mason-lspconfig.nvim",
	},
}
