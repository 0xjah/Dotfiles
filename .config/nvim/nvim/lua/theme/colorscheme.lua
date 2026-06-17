vim.o.background = "dark"
vim.cmd.colorscheme("monoglow")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "Float", { bg = "none" })
vim.cmd(":hi statusline guibg=NONE")
