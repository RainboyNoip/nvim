-- nvim-cmp 补全相关的配置

return {

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },


  -- cmp-dictionary
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "uga-rosa/cmp-dictionary" },
    ---@param opts cmp.ConfigSchema
    opts = function (_,opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "dictionary",keyword_length = 2 } }))

      local dict = require("cmp_dictionary")
      dict.setup({
          -- The following are default values.
          exact = 2,
          first_case_insensitive = false,
          document = false,
          document_command = "wn %s -over",
          async = false,
          sqlite = false,
          max_items = -1,
          capacity = 5,
          debug = false,
      })


      -- nvim cmp dictionary --
      vim.o.spelllang = "en"
      local word_path = vim.fn.stdpath("config") .. "/dictionary/google-10000-english-no-swears.txt"
      -- print(word_path)
      dict.switcher({
          spelllang = {
              en = word_path
          },
      })
    end,
  },
  
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
            local termcodes = vim.api.nvim_replace_termcodes('<C-g>u', true, true, true)
            vim.api.nvim_feedkeys(termcodes, 'i', true)
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
}
