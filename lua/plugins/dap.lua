return {
    {
        "rcarriga/nvim-dap-ui",
        opts = {
            element_mappings = {
                scopes = { edit = "e", repl = "r", },
                watches = { edit = "e", repl = "r", },
                stacks = { open = "g", },
                breakpoints = { open = "g", toggle = "b", },
            },
            layouts = {
                {
                    elements = { "scopes", "stacks", "breakpoints", "watches", },
                    size = 0.2, -- 40 columns
                    position = "left",
                },
                {
                    elements = { "repl", },
                    size = 0.25, -- 25% of total lines
                    position = "bottom",
                },
                {
                    elements = { "console", },
                    size = 0.2,
                    position = "right",
                },
            },

            floating = {
                max_height = nil, -- These can be integers or a float between 0 and 1.
                max_width = nil, -- Floats will be treated as percentage of your screen.
                border = "rounded", -- Border style. Can be "single", "double" or "rounded"
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
        },
        config = function(_, opts)
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end
        end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function ()
            local Config = require("lazyvim.config")
            local dap = require('dap')
            vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

            for name, sign in pairs(Config.icons.dap) do
                sign = type(sign) == "table" and sign or { sign }
                vim.fn.sign_define(
                "Dap" .. name,
                { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
                )
            end

            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = '/home/rainboy/bin/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
            }
            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        local currentFileName = vim.api.nvim_buf_get_name(0)
                        -- local currentFileName = vim.fn.expand("%")
                        local newFileName = currentFileName:gsub('%.%w+$', '.out')

                        local exists = vim.fn.filereadable(newFileName) == 1

                        print(newFileName)
                        -- if exists then
                        --     print("File already exists")
                        -- end
                        return newFileName
                        -- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    args = {"<","in"},
                    stopAtEntry = true,
                },
            }

        end,
        keys = {
            { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
            { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
            { "<leader>dj", function() require("dap").down() end, desc = "Down" },
            { "<leader>dk", function() require("dap").up() end, desc = "Up" },
            { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
            { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
            { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
            { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
            { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
            { "<leader>ds", function() require("dap").session() end, desc = "Session" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
            { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
            -- 结束
            { "<F4>", function() 
                require("dap").terminate()
                require("dapui").close()
            end, desc = "Terminate" },
            -- 启动调试/继续执行
            { "<F5>", function() require("dap").continue() end, desc = "Continue" },
            -- 切换断点
            { "<F6>", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            -- step_into
            { "<F7>", function() require("dap").step_into() end, desc = "Step Into" },
            -- step out
            { "<F8>", function() require("dap").step_over() end, desc = "Step Over" },
            { "<F9>", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
            { "n", function()
                local dap = require("dap")
                if( dap.session()) then
                    dap.step_over()
                else
                    return "n"
                end
            end, desc = "Step Over" ,mode = "n", expr = true},
            { "i", function()
                local dap = require("dap")
                if( dap.session()) then
                    dap.step_into()
                else
                    return "i"
                end
            end, desc = "Step Into" ,mode = "n",expr = true},
            { "b", function()
                local dap = require("dap")
                if( dap.session()) then
                    dap.toggle_breakpoint()
                else
                    vim.api.nvim_command("normal! b")
                end
            end, desc = "Step Over" ,mode = "n"},
            { "r", function()
                local dap = require("dap")
                if( dap.session()) then
                    dap.restart()
                else
                    vim.api.nvim_command("normal! r")
                end
            end, desc = "Step Over" ,mode = "n"},
            { "u", function()
                local dap = require("dap")
                if( dap.session()) then
                    dap.run_to_cursor()
                else
                    return "u"
                end
            end, desc = "run to cursor" ,mode = "n",expr = true},
        },
    },
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
      config=function (_,opts)
          require("nvim-dap-virtual-text").setup(opts)
      end
    },


}
