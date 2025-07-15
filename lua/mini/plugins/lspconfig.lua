return {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	keys = require("mini.plugins.keys.lsp-keys"),
	config = function(_, _)
		require("mini.plugins.config.lang-servers")
	end,
}
