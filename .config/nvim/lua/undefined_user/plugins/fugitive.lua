return {
    "tpope/vim-fugitive",

    config = function()
        vim.keymap.set("n", "<leader>fg", vim.cmd.Git)
    end
}
