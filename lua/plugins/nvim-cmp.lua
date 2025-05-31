return {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
    },
    -- Not all LSP servers add brackets when completing a function.
    -- To better deal with this, LazyVim adds a custom option to cmp,
    -- that you can configure. For example:
    --
    -- ```lua
    -- opts = {
    --   auto_brackets = { "python" }
    -- }
    -- ```
    opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")
        local defaults = require("cmp.config.default")()
        local auto_select = true
        local luasnip = require("luasnip")
        return {
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            auto_brackets = {}, -- configure any filetype to auto add brackets
            completion = {
                completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
            },
            preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
            mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                ["<C-n>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    elseif cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        fallback()
                    end
                end,{ "i", "s"}),
                ["<C-j>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(1) then
                        luasnip.jump(1)
                    elseif cmp.visible() then
                        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        fallback()
                    end
                end,{ "i", "s"}),
                ["<C-k>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    elseif cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-p>"] = cmp.mapping(function(fallback)
                    if luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    elseif cmp.visible() then
                        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                    else
                        fallback()
                    end
                end, { "i", "s" }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<CR>"] = LazyVim.cmp.confirm({ select = auto_select }),
                ["<C-y>"] = LazyVim.cmp.confirm({ select = true }),
                ["<S-CR>"] = LazyVim.cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                ["<C-CR>"] = function(fallback)
                    cmp.abort()
                    fallback()
                end,
                -- ["<tab>"] = function(fallback)
                --     return LazyVim.cmp.map({ "snippet_forward", "ai_accept" }, fallback)()
                -- end,
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
                
            }),
            sources = cmp.config.sources({
                { name = "luasnip" },
                { name = "lazydev" },
                { name = "nvim_lsp" },
                { name = "path" },

            }, {
                { name = "buffer" },
            }),
            formatting = {
                format = function(entry, item)
                    local icons = LazyVim.config.icons.kinds
                    print("entry.source", entry.source.name)
                    local source_name = entry.source.name
                    if source_name == 'nvim_lsp' then
                        --   item.menu = '[lsp] ' -- 或使用 emoji: ❤️ [lsp]
                        item.kind = '❤️  ' .. item.kind
                    elseif source_name == 'buffer' then
                        -- item.menu = '[buf] ' -- 或使用 emoji: 📄 [buf]
                        item.kind = '[buf]' .. item.kind
                    elseif source_name == 'luasnip' then
                        -- item.menu = '[snip]' -- 或使用 emoji: ✨ [snip]
                        item.kind = '✨  ' .. item.kind
                    elseif source_name == 'path' then
                        -- item.menu = '[path]' -- 或使用 emoji: 📂 [path]
                        item.kind = '📂' .. item.kind
                        -- 添加其他你使用的补全来源
                        -- elseif source_name == 'another_source' then
                        --   item.menu = '[anr] '
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
    main = "lazyvim.util.cmp",
}
