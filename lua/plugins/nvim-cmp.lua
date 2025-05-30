-- nvim-cmp 补全相关的配置

return {

	-- override nvim-cmp and add cmp-emoji
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	dependencies = {},
	-- 	---@param opts cmp.ConfigSchema
	-- 	opts = function(_, opts)
	-- 		local cmp = require("cmp")
	-- 		opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
	-- 	end,
	-- },
	--
	-- cmp-dictionary
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "uga-rosa/cmp-dictionary", "L3MON4D3/LuaSnip", "hrsh7th/cmp-emoji" },
		opts = function(_, opts)
			vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			local defaults = require("cmp.config.default")()
			local auto_select = true
			opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
			return {
				auto_brackets = {}, -- configure any filetype to auto add brackets
				completion = {
					completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
				},
				preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
				mapping = {
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								print("yes")
								-- luasnip.expand()
							else
								cmp.confirm({
									select = true,
								})
							end
						else
							fallback()
						end
					end),

					["<Tab>"] = cmp.mapping(function(fallback)
						print(luasnip.expand_or_jumpable())
						if luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				sources = cmp.config.sources({
					{ name = "lazydev" },
					{ name = "nvim_lsp" },
					{ name = "path" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					format = function(entry, item)
						local icons = LazyVim.config.icons.kinds
						if icons[item.kind] then
							item.kind = icons[item.kind] .. item.kind
						end

						local widths = {
							abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
							menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
						}

						for key, width in pairs(widths) do
							if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
								item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
							end
						end

						return item
					end,
				},
				experimental = {
					-- only show ghost text when we show ai completions
					ghost_text = vim.g.ai_cmp and {
						hl_group = "CmpGhostText",
					} or false,
				},
				sorting = defaults.sorting,
			}
		end,
	},

	-- then: setup supertab in cmp
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	---@param opts cmp.ConfigSchema
	-- 	opts = function(_, opts) end,
	-- },
}
