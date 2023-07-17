# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## snippets

基于[LuaSnip](https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md) 的`snippets`是整个配置的核心


- `tt`



## 配置dap


在`lua/config/lazy.lua`这里添加`{ import = "lazyvim.plugins.extras.dap.core" }`

```
require("lazy").setup({
  spec = {
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.dap.core" },
    { import = "plugins" },
  },
})
```

配置`cpp`,`dap.configurations.cpp`

No configuration found for `cpp`. You need to add configs to `dap.configurations.cpp` (See `:h dap-configuration`)
