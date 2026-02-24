local tab_width = 4

vim.o.termguicolors  = true
vim.o.number         = true
vim.o.relativenumber = true
vim.o.signcolumn     = "auto"
vim.o.wrap           = false
vim.o.shiftwidth     = tab_width
vim.o.tabstop        = tab_width
vim.o.cursorcolumn   = false
vim.o.cursorline     = true
vim.o.expandtab      = false

vim.diagnostic.config({
    virtual_text = true,
})
