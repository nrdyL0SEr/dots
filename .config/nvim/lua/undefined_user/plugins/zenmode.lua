return {
        "folke/zen-mode.nvim",

        config = function()
            vim.keymap.set("n", "<leader>ze", function()
                require("zen-mode").toggle({
                    window = {
                        backdrop = 1,
                        options = {
                            signcolumn = "no",
                            colorcolumn = "0",
                        },
                    },

                    ---@diagnostic disable-next-line: unused-local
                    on_open = function(win)
                        require('fidget').progress.suppress(true)
                    end,

                    on_close = function()
                        require('fidget').progress.suppress(false)
                    end
                })
            end)
        end
    }
