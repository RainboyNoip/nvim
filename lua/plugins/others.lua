-- 一些其它的插件
return {
  {
    -- switch and restore fcitx state for each buffer
    'h-hg/fcitx.nvim'
  },
  -- add symbols-outline
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      { "<F3>",'<cmd>AerialToggle<cr>', desc = "aerial toggle" },
      { "<S-F3>",'<cmd>AerialNavToggle<cr>', desc = "aerial toggle" },
    }
  }
}
