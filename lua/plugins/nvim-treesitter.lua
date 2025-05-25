return {
	{
		"nvim-treesitter/nvim-treesitter",
		config = function(_, opts)
			-- config from here: https://github.com/nvim-treesitter/nvim-treesitter/issues/1888
			require("nvim-treesitter.install").prefer_git = true
		end,
	},
}
