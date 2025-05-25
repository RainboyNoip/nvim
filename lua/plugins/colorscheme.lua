return {

	-- add gruvbox
	{
		"ellisonleao/gruvbox.nvim",
		enable = false,
		config = function()
			require("gruvbox").setup({
				transparent_mode = true,
			})
		end,
	},
	{
		"sainnhe/gruvbox-material",
		enable = true,
	},

	-- nightfox
	{
		"EdenEast/nightfox.nvim",
		config = function()
			require("nightfox").setup({
				options = {
					alt_nc = true,
					visual = true,
					search = true,
					styles = {
						comment = "italic",
						keywords = "bold",
						numbers = "bold",
						functions = "italic,bold",
					},
				},
			})
		end,
	},

	-- Configure LazyVim to load gruvbox
	{
		"LazyVim/LazyVim",
		opts = {
			colorscheme = "gruvbox",
			-- colorscheme = "carbonfox",
			-- colorscheme = "terafox",
			-- colorscheme = "gruvbox-material",
		},
	},
}
