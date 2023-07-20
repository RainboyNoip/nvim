-- mini.nvim 相关插件的配置
--

return {
    {
        'echasnovski/mini.map',
        version = '*',
        config = function ()
            local minimap = require('mini.map')
            minimap.setup(
            -- No need to copy this inside `setup()`. Will be used automatically.
            {
                -- Highlight integrations (none by default)
                integrations = nil,

                -- Symbols used to display data
                symbols = {
                    -- Encode symbols. See `:h MiniMap.config` for specification and
                    -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
                    -- Default: solid blocks with 3x2 resolution.
                    -- encode = MiniMap.gen_encode_symbols.dot('4x2'),
                    encode = minimap.gen_encode_symbols.dot('4x2'),
                    -- Scrollbar parts for view and line. Use empty string to disable any.
                    scroll_line = '█',
                    scroll_view = '┃',
                    -- scroll_view = '⣿',
                },

                -- Window options
                window = {
                    -- Whether window is focusable in normal way (with `wincmd` or mouse)
                    focusable = false,

                    -- Side to stick ('left' or 'right')
                    side = 'right',

                    -- Whether to show count of multiple integration highlights
                    show_integration_count = true,

                    -- Total width
                    width = 15,

                    -- Value of 'winblend' option
                    winblend = 25,
                },
            }
            )
        end,
        keys = {
            { "<leader>mo",function () MiniMap.open() end, desc = "mini-map open" },
            { "<leader>mc",function () MiniMap.close() end, desc = "mini-map close" },
            { "<leader>mf",function () MiniMap.toggle_focus() end, desc = "mini-map toggle focus" },
            { "<leader>mr",function () MiniMap.refresh() end, desc = "mini-map refresh" },
            { "<leader>ms",function () MiniMap.toggle_side() end, desc = "mini-map toggle side" },
            { "<leader>mt",function () MiniMap.toggle() end, desc = "mini-map toggle" },
            { "<F3>",function () MiniMap.toggle() end, desc = "mini-map toggle" },
            -- encode = MiniMap.gen_encode_symbols.dot()
        },

        dependencies = {
            {
                "folke/which-key.nvim",
                config = function ()
                    local wk = require("which-key")
                    wk.register({
                        ["<leader>m"] = {name = "+mini.map"}
                    })
                end
            }
        }
    },
}
