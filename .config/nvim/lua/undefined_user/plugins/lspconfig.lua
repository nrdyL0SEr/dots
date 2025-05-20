return {
    "neovim/nvim-lspconfig",

    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "j-hui/fidget.nvim",
        'hrsh7th/cmp-nvim-lsp',
    },

    config = function()
        local cmp_lsp = require('cmp_nvim_lsp')
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        require('lspconfig.ui.windows').default_options.border = 'rounded'

        require('fidget').setup({ notification = { window = { winblend = 0 } } })
        require("mason").setup({ ui = { border = "rounded" } })

        require("mason-lspconfig").setup({
            ensure_installed = { 'jdtls', 'lua_ls', }, -- 'gradle_ls', },

            handlers = {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities
                    }
                end,
            }
        })
    end
}
