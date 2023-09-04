vim.cmd([[autocmd BufNewFile,BufRead *.asy setlocal filetype=asy ]])

-- vim.lsp.start({
--   name = 'asy lsp server',
--   cmd = {'/usr/bin/asy','-lsp'}
-- })

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Asymptote LSP
-- local lspconfig = require 'lspconfig'
-- local configs = require 'lspconfig.configs'
-- local util = require 'lspconfig.util'

-- if not configs.asy_ls then
--    configs.asy_ls = {
--     default_config = {
--       cmd = {'asy', '-lsp'},
--       filetypes = {'asy'},
--       root_dir = function(fname)
--         return util.find_git_ancestor(fname)
--       end,
--       single_file_support = true,
--       settings = {},
--     },
--   }
-- end
-- lspconfig.asy_ls.setup{}
