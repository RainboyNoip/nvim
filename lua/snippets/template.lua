local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt


local file = io.open("/home/rainboy/mycode/RainboyNoip/algorithms/template.cpp", "r")
local content = file:read("*a")
file:close()

local function getCurrentTime()
    local currentTime = os.date("%Y-%m-%d %H:%M:%S")
    return currentTime
end

return  s("tt",
    fmt(content,{ time =f(getCurrentTime) , ipos = i(0)})
)
