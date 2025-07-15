return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		-- Useful for getting pretty icons, but requires a Nerd Font.
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	main = "telescope",
	keys = {

		{
			"<leader>cd",
			require("telescope.builtin").lsp_definitions,
			desc = "[G]oto [D]efinition",
			mode = "n",
			silent = true,
		},
		{
			"<leader>cg",
			require("telescope.builtin").diagnostics,
			desc = "[G]oto [D]iagnostics",
			mode = "n",
			silent = true,
		},

		-- Find references for the word under your cursor.
		{
			"<leader>cR",
			require("telescope.builtin").lsp_references,
			desc = "[G]oto [R]eferences",
			mode = "n",
			silent = true,
		},

		-- Jump to the implementation of the word under your cursor.
		--  Useful when your language has ways of declaring types without an actual implementation.
		{
			"<leader>cI",
			require("telescope.builtin").lsp_implementations,
			desc = "[G]oto [I]mplementation",
			mode = "n",
			silent = true,
		},

		-- Jump to the type of the word under your cursor.
		--  Useful when you're not sure what type a variable is and you want to see
		--  the definition of its *type*, not where it was *defined*.
		{
			"<leader>ct",
			require("telescope.builtin").lsp_type_definitions,
			desc = "Type [D]efinition",
			mode = "n",
			silent = true,
		},

		-- Fuzzy find all the symbols in your current document.
		--  Symbols are things like variables, functions, types, etc.
		{
			"<leader>cs",
			require("telescope.builtin").lsp_document_symbols,
			desc = "[D]ocument [S]ymbols",
			mode = "n",
			silent = true,
		},

		-- Fuzzy find all the symbols in your current workspace.
		--  Similar to document symbols, except searches over your entire project.
		{
			"<leader>cw",
			require("telescope.builtin").lsp_dynamic_workspace_symbols,
			desc = "[W]orkspace [S]ymbols",
			mode = "n",
			silent = true,
		},
		{
			"<leader>sh",
			require("telescope.builtin").help_tags,
			desc = "[S]earch [H]elp",
			mode = "n",
		},
		{
			"<leader>sk",
			require("telescope.builtin").keymaps,
			desc = "[S]earch [K]eymaps",
			mode = "n",
		},
		{
			"<leader>sf",
			require("telescope.builtin").find_files,
			desc = "[S]earch [F]iles",
			mode = "n",
		},
		{
			"<leader>ss",
			require("telescope.builtin").builtin,
			desc = "[S]earch [S]elect Telescope",
			mode = "n",
		},
		{
			"<leader>sw",
			require("telescope.builtin").grep_string,
			desc = "[S]earch current [W]ord",
			mode = "n",
		},
		{
			"<leader><leader>",
			require("telescope.builtin").buffers,
			desc = "[S]earch Find existing buffers",
			mode = "n",
		},
		{
			"<leader>sg",
			require("telescope.builtin").live_grep,
			desc = "[S]earch by [G]rep",
			mode = "n",
		},
	},
	opts = {
		-- You can put your default mappings / updates / etc. in here
		--  All the info you're looking for is in `:help telescope.setup()`
		--
		-- defaults = {
		--   mappings = {
		--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
		--   },
		-- },
		-- pickers = {}
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
	},
	config = function(plugin, opts)
		pcall(require(plugin.main).load_extension, "fzf")
		pcall(require(plugin.main).load_extension, "ui-select")

		require(plugin.main).setup(opts)
	end,
}
