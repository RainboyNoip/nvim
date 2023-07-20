return {

  -- add clangd to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- clangd = {
        --     cmd = {"clangd","--compile-commands-dir=\"/home/rainboy/mycode/RainboyNoip/algorithms/config\""},
        --     single_file_support = true
        -- },

      },
    },
    config = function ()
        -- require("lspconfig").clangd.setup{
        --     cmd = {"clangd"},
        --     single_file_support = true
        -- }
    require("lspconfig").ccls.setup({
        single_file_support = true,
        init_options = {
            cache = {
                directory = "/tmp/ccls-cache"
            },
            compilationDatabaseDirectory = "build";
            index = {
                threads = 0;
            };
            clang = {
                -- excludeArgs = { "-frounding-math"} ;
                extraArgs = {"-std=c++20","-DDEBUG"}
            };
        }
    })
    end
  },
}
