return {
    -- {
    --     "rafamadriz/friendly-snippets",
    --     enabled = false
    -- },
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "rafamadriz/friendly-snippets",
            -- config = function()
                --   require("luasnip.loaders.from_vscode").lazy_load()
                -- end,
        },
        config = function ()
            require("luasnip.loaders.from_vscode").lazy_load({ exclude = {"cpp"} })
            require("luasnip.loaders.from_lua").load()
        end,
        opts = {
            history = true,
            delete_check_events = "TextChanged",
        },
        -- stylua: ignore
        keys = {
            {
                "<tab>",
                function()
                    return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
                end,
                expr = true, silent = true, mode = "i",
            },
            { "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
            { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
            { "<c-j>", 
                function() 
                    local ls = require("luasnip")
                    if (ls.expand_or_jumpable()) then
                        ls.jump(1)
                    else
                        return "<c-j>"
                    end
                end,
                expr = true, silent = true,mode = {"i","s"} },
            { "<c-k>", 
                function() 
                    local ls = require("luasnip")
                    if (ls.jumpable(-1)) then
                        ls.jump(-1)
                    else
                        return "<c-k>"
                    end
                end,
                expr = true, silent = true, mode = "s" },
            {"<C-E>", function ()
                local ls = require("luasnip")
                if( ls.choice_active() ) then
                    ls.change_choice(1)
                end
            end,mode={"i","s"}}
        },

    }
}
-- vim.keymap.set({"i", "s"}, "<C-E>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(1)
-- 	end
-- end, {silent = true})
