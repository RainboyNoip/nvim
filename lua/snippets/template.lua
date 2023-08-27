local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

local uv = vim.loop

-- Check if the directory exists
local function directory_exists(path)
    local stat = uv.fs_stat(path)
    return stat and stat.type == 'directory'
end

local content = "not exits"
local content_normal = "not exists"

if directory_exists("/home/rainboy/mycode/RainboyNoip/algorithms/") then
    local file = io.open("/home/rainboy/mycode/RainboyNoip/algorithms/template.cpp", "r")
    content = file:read("*a")
    file:close()

    file = io.open("/home/rainboy/mycode/RainboyNoip/algorithms/template_normal.cpp", "r")
    content_normal = file:read("*a")
    file:close()
end

local function getCurrentTime()
    local currentTime = os.date("%Y-%m-%d %H:%M:%S")
    return currentTime
end

-- return { 
--     -- template template
--     s("tt",
--     fmt(content,{ time =f(getCurrentTime) , ipos = i(0)})
--     ),
--     -- template normal
--     s("tn",
--     fmt(content_normal,{ time =f(getCurrentTime) , ipos = i(0)})
--     )
-- }
return {}
