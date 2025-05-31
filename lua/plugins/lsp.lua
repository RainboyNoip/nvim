return {

	-- add clangd to lspconfig
	{
		"neovim/nvim-lspconfig",
		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
			servers = {
				-- clangd = {
				--     cmd = {"clangd","--compile-commands-dir=\"/home/rainboy/mycode/RainboyNoip/algorithms/config\""},
				--     single_file_support = true
				-- },
			},
		},
		config = function()
			local capabilities = require('cmp_nvim_lsp').default_capabilities()
			-- 我的nvim-cmp 配合 luansip 使用的时候,不能展开函数的参数
			-- https://github.com/hrsh7th/cmp-nvim-lsp
			-- 根据上面的这个 Readme 里面的描述,修改如下, 加入 capabilities = capabilities, 解决这个问题
			require("lspconfig").clangd.setup{
			    -- cmd = {"clangd"},
			    single_file_support = true,
				capabilities = capabilities
			}
			-- require("lspconfig").ccls.setup({
			-- 	-- single_file_support = true,
			-- 	init_options = {
			-- 		cache = {
			-- 			directory = "/tmp/ccls-cache",
			-- 		},
			-- 		client = {
			-- 			snippetSupport = true,
			-- 		},
			-- 		completion = {
			-- 			placeholder = true,
			-- 		},
			-- 		compilationDatabaseDirectory = "build",
			-- 		index = {
			-- 			threads = 0,
			-- 		},
			-- 		clang = {
			-- 			-- excludeArgs = { "-frounding-math"} ;
			-- 			extraArgs = { "-std=c++20", "-DDEBUG" },
			-- 		},
			-- 	},
			-- })
			require("lspconfig").tsserver.setup({})
			require("lspconfig").jedi_language_server.setup({})
			require("lspconfig").lua_ls.setup({
				on_init = function(client)
					if client.workspace_folders then
						local path = client.workspace_folders[1].name
						if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
							return
						end
					end

					client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
						runtime = {
							-- Tell the language server which version of Lua you're using
							-- (most likely LuaJIT in the case of Neovim)
							version = "LuaJIT",
						},
						-- Make the server aware of Neovim runtime files
						workspace = {
							checkThirdParty = false,
							library = {
								vim.env.VIMRUNTIME,
								-- Depending on the usage, you might want to add additional paths here.
								-- "${3rd}/luv/library"
								-- "${3rd}/busted/library",
							},
							-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
							-- library = vim.api.nvim_get_runtime_file("", true)
						},
					})
				end,
				settings = {
					Lua = {},
				},
			})
		end,
	},

	-- "ray-x/lsp_signature.nvim",
	-- {
	--     "ray-x/lsp_signature.nvim",
	--     event = "VeryLazy",
	--     opts = {},
	--     config = function(_, opts) require'lsp_signature'.setup(opts) end
	-- }
}
