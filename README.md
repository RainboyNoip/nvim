# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## snippets

基于[LuaSnip](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md) 的`snippets`是整个配置的核心


- `tt` template with algorithms library
- `tn` template normal

## 配置dap

在`lua/config/lazy.lua`这里添加`{ import = "lazyvim.plugins.extras.dap.core" }`
然后在`plugins/dap.lua`进行相配的配置

快捷键:


- 结束 F4
- 启动调试/继续执行 F5
- 切换断点 F6
- `step_into` F7
- `step out` F8
- `run to cursor` F9
- `<leader>a` toggle folder
- `F9` open float termial

## oiSnippets

这个文件是用来配置`oiSnippets`的, `<F1>`可以快速插入`oiSnippets`的模板