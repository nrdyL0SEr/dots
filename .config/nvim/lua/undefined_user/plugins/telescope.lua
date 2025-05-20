return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5", -- there are problems in the moset recent tag 🤷

    dependencies = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
    },

    config = function()
        require('telescope').setup({})

        local builtin = require('telescope.builtin')

        vim.keymap.set('n', '<leader>.', function()
            builtin.find_files({ hidden = true });
        end)
        vim.keymap.set('n', '<leader>gs', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
    end
}

