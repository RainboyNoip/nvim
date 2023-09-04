return {
    {

        "epwalsh/obsidian.nvim",
        lazy = true,
        -- event = { "BufReadPre path/to/my-vault/**.md" },
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand':
        event = { "BufReadPre " .. vim.fn.expand "~" .. "/mycode/obsidian/RainboyData/**.md" },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",

            -- see below for full list of optional dependencies 👇
        },
        opts = {
            dir = "~/mycode/obsidian/RainboyData/",  -- no need to call 'vim.fn.expand' here

            -- see below for full list of options 👇
            -- Optional, completion.
            completion = {
                -- If using nvim-cmp, otherwise set to false
                nvim_cmp = true,
                -- Trigger completion at 2 chars
                min_chars = 2,
                -- Where to put new notes created from completion. Valid options are
                --  * "current_dir" - put new notes in same directory as the current buffer.
                --  * "notes_subdir" - put new notes in the default notes subdirectory.
                new_notes_location = "current_dir",

                -- Whether to add the output of the node_id_func to new notes in autocompletion.
                -- E.g. "[[Foo" completes to "[[foo|Foo]]" assuming "foo" is the ID of the note.
                prepend_note_id = true
            },
            -- Optional, key mappings.
            mappings = {
                -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                -- ["gf"] = require("obsidian.mapping").gf_passthrough(),
            },
        },
    }
}
