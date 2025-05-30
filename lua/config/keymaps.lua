-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")

-- short cut key

vim.api.nvim_set_keymap("i", "<c-l>", "<esc>A", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-h>", "<esc>I", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<F2>", ":Neotree toggle<cr>", { noremap = true, silent = true })

-- qq 快速保存退出
vim.api.nvim_set_keymap("n","qq",":wq<cr>",{noremap = true, silent = true})

-- float terminal
vim.keymap.set("n", "<F9>", function() Util.float_term() end, { desc = "Terminal (cwd)" })
vim.keymap.set("t", "<F9>", "<cmd>close<cr>", { desc = "Hide Terminal" })


-- fold
--- nnoremap <space> za
vim.keymap.set("n", "<leader>a" , "za", { noremap = true, silent = true })

