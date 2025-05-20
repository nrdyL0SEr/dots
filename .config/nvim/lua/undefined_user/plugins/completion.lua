return {
    {
        "L3MON4D3/LuaSnip",

        dependencies = "rafamadriz/friendly-snippets",

        config = function ()
            local luasnip = require("luasnip")
            vim.keymap.set({ "i", "s" }, "<C-.>", function() luasnip.jump(1) end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-,>", function() luasnip.jump(-1) end, { silent = true })
        end
    },

    {
        'hrsh7th/nvim-cmp',

        dependencies = {
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-buffer',
            "onsails/lspkind-nvim",
        },

        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            local cmp_select = { behavior = cmp.SelectBehavior.Select }
            cmp.setup({

                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },

                mapping = cmp.mapping.preset.insert({
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ["<C-Space>"] = cmp.mapping.complete(),
                }),

                sources = cmp.config.sources({
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' }, -- Dependency at ~/.config/nvim/lua/undefined_user/plugins/lspconfig.lua
                    { name = 'path' },
                    { name = 'buffer' },
                }),

                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 50,
                        ellipsis_char = '...',
                        show_labelDetails = true,
                    })
                }
            })
        end
    }
}
