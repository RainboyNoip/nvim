-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
local opt = vim.opt
opt.tabstop = 4 -- Number of spaces tabs count for
opt.shiftwidth = 4

-- 我现在需要lazyvim的默认配置了 +=unnamedplus
-- opt.clipboard = "unnamed"



-- enable fold
opt.foldenable = true
opt.foldmethod = "marker" -- use marker to fold code
-- opt.foldmarker = { "{", "}" }
opt.foldlevel = 99
