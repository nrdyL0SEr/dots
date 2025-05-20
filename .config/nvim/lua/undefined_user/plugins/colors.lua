function ColorMyPencils(color)
    color = color or "midnight"
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

function LineNumberColors()
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='gray', bold=true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='gray', bold=true })
    vim.api.nvim_set_hl(0, 'CursorLineNR', { ctermbg=lightgray })
end


return {
    {
        'dasupradyumna/midnight.nvim',
        config = function ()
            vim.cmd('colorscheme midnight')
            ColorMyPencils()
            LineNumberColors()
        end
    },

    {
        'yorickpeterse/vim-paper',
        config = function ()
            vim.cmd('colorscheme paper')
            ColorMyPencils()
            LineNumberColors()
        end
    }
}
