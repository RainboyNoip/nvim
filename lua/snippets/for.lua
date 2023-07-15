local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt



-- 常用的for循环

return {

    -- Yank to array
    -- 1d array
    s("f",
        fmt(
        [[
            F({choice}){{
                {pos}
            }}
        ]],
        {
            pos=i(0),
            choice=i(1,"n")
        })
    ),
    -- 2d array
    s("ff",
        fmt(
        [[
            FF({snip}){{
                {pos}
            }}
        ]],
        {
            pos=i(0),
            snip=sn(1,{t(" "),i(1,"i"),t(" , "),i(2,"n"),t(" ")})
        })
    ),
    -- 3d array
    s("f3",
        fmt(
        [[
            F3({snip}){{
                {pos}
            }}
        ]],
        {
            pos=i(0),
            snip=sn(1,{t(" "),i(1,"i"),t(" , "),i(2,"s"),t(" , "),i(3,"t")})
        })
    )

}
