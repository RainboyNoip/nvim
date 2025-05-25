local fzf = require("fzf-lua")

local mytest = coroutine.wrap(function()
	local result = fzf.fzf({ "choice 1", "choice 2" })
	if result then
		print(result[1])
	end
end)

function InsertSnippet()
	local bufnr = vim.api.nvim_get_current_buf()
	local winid = vim.api.nvim_get_current_win()
	fzf.fzf_exec("find ~/.config/nvim/snippets/ -type f -maxdepth 2", {
		prompt = "Select snippet> ",
		fzf_opts = {
			["--preview"] = "cat {}",
			["--preview-window"] = "right:50%",
		},
		actions = {
			["enter"] = {
				-- fn = require'fzf-lua'.actions.file_edit,
				fn = function(selected)
					if #selected > 0 then
						local path = selected[1]
						local lines = vim.fn.readfile(path)
						if lines then
							local row, col = unpack(vim.api.nvim_win_get_cursor(winid))
							vim.api.nvim_buf_set_text(bufnr, row, col, row, col, lines)
							local n = #lines
							if n > 0 then
								local new_row = row + n - 1
								local new_col = #lines[n]
								vim.api.nvim_win_set_cursor(winid, { new_row, new_col })
							end
						end
						local fzf_winid = vim.api.nvim_get_current_win()
						vim.api.nvim_win_close(fzf_winid, true)
					end
				end,
				reload = true,
			},
			["ctrl-y"] = {
				fn = function(selected)
					print(selected)
					print("y hello")
				end,
			},
			["ctrl-x"] = {
				fn = function(selected)
					print(selected)
					print("x hello")
				end,
				reload = true,
			},
		},
	})
end

vim.api.nvim_create_user_command("Choose", function()
	-- mytest()
	-- InsertSnippet()
	print("hello")
end, {})
