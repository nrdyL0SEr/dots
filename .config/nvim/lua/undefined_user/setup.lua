vim.opt.updatetime = 50
vim.opt.guicursor = ""
vim.opt.laststatus = 3
vim.opt.colorcolumn = "80"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "screenline"

vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.cache/nvim/undodir"
vim.opt.undofile = true

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 0
vim.g.netrw_altv = true

-- KEYMAPS

-- WHERE"S THE MAP!@@!@#>>? HERE IT IS!!!! SIKE YOU THOUGHT!!
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ad", vim.cmd.Ex)

-- Yall got me FUNKED up if you think I'm reachin my teenie pinkie for that teeny escape key
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Sweet mother of magaldene, this brings a tear to my eye (also a pain in my back)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- NO deisiointing movemnet
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- CLIP DAT THING MRS! DJFKSFLJDSYAY@@
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])

-- This is to send whatever you're doing to THE VOID!!
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>tn", function()
    vim.opt.number = not(vim.opt.number:get())
    vim.opt.relativenumber = not(vim.opt.relativenumber:get())
    LineNumberColors()
end)
