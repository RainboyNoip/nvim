return {
	-- {
	--     "rafamadriz/friendly-snippets",
	--     enabled = false
	-- },
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			-- "rafamadriz/friendly-snippets",
			-- config = function()
			-- 	-- 加上exclude 确实不会加载cpp了,但是也不会加载我自己的cpp的snippets
			-- 	-- require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "cpp" } })
			-- end,
		},
		opts = {
			history = false,
			delete_check_events = { "TextChanged", "InsertLeave" },
			update_events = { "TextChanged", "TextChangedI" },
		},
		config = function(_, opts)
			-- print(opts)
			require("luasnip").setup(opts)
			-- require("luasnip.loaders.from_vscode").lazy_load({ exclude = { "cpp" } })
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_snipmate").lazy_load({ path = vim.fn.stdpath("config") })
			require("luasnip.loaders.from_lua").load()
		end,
		-- stylua: ignore
		-- keys = {
		--     {
		--         "<tab>",
		--         function()
		--             return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
		--         end,
		--         expr = true, silent = true, mode = "i",
		--     },
		--     { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
		--     { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
		--     { "<c-j>",
		--         function()
		--             local ls = require("luasnip")
		--             if (ls.expand_or_jumpable()) then
		--                 ls.jump(1)
		--             else
		--                 return "<c-j>"
		--             end
		--         end,
		--         expr = true, silent = true,mode = {"i","s"} },
		--     { "<c-k>",
		--         function()
		--             local ls = require("luasnip")
		--             if (ls.jumpable(-1)) then
		--                 ls.jump(-1)
		--             else
		--                 return "<c-k>"
		--             end
		--         end,
		--         expr = true, silent = true, mode = "s" },
		--     {"<C-E>", function ()
		--         local ls = require("luasnip")
		--         if( ls.choice_active() ) then
		--             ls.change_choice(1)
		--         end
		--     end,mode={"i","s"}}
		-- },
	},
}
-- vim.keymap.set({"i", "s"}, "<C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, {silent = true})
