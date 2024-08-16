-- 来自,关闭那些我不需要的插件
-- http://www.lazyvim.org/configuration/plugins#-disabling-plugins
return {
	{
		-- friendly-snippets 会污染我的snippets
		"rafamadriz/friendly-snippets",
		enabled = false,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		enabled = false,
	},
}
