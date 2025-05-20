return {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "vimdoc", "lua", "bash", "java", "markdown"
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            indent = {
                enable = true
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,
            },
        })
    end
}
