return {
	"marko-cerovac/material.nvim",
	lazy = false,
	main = "material",
	init = function()
		vim.cmd("colorscheme material")
	end,
	config = function(plugin, _)
		vim.g.material_style = "deep ocean"
		require(plugin.main).setup()
	end,
}
