-- My Minimal NVim Setup --

-- Vim Decorations
vim.o.winborder = "rounded"
vim.o.tabstop = 2
vim.o.cursorcolumn = false
vim.o.ignorecase = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.undofile = true
vim.o.incsearch = true
vim.o.signcolumn = "yes"

-- Keymappiing
local map = vim.keymap.set
vim.g.mapleader = " "
map('n', '<leader>o', ':update<CR> :source<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
map({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>')
map({ 'n', 'v', 'x' }, '<leader>S', ':sf #<CR>')

-- Plugin Manager(Native)
vim.pack.add({
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/uZer/pywal16.nvim" },
	{ src = "https://github.com/nordtheme/vim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-lualine/lualine.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
})

-- PLugin require
require "mason".setup()
require "mini.pick".setup()
require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"svelte",
		"typescript",
		"javascript",
		"css",
	},
	highlight = { enable = true },
})
require "oil".setup()

-- lsp
vim.env.PATH = vim.env.PATH .. ':' .. vim.fn.stdpath('data') .. '/mason/bin'
vim.lsp.enable({
	"lua_ls",
	"clangd",
	"gopls"
})

-- autocompletions
vim.o.completeopt = "menuone,noselect"
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
	end
})
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"',
	{ noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("i", "<CR>", 'pumvisible() ? "<C-y>" : "<CR>"', { noremap = true, expr = true, silent = true })

-- Plugin keymapping
map('n', '<leader>f', ":Pick files<CR>")
map('n', '<leader>h', ":Pick help<CR>")
map('n', '<leader>e', ":Oil<CR>")
map('n', '<leader>lf', vim.lsp.buf.format)

-- Status Line
require('lualine').setup()
require("lualine").setup({
	options = {
		icons_enabled = false,
		theme = "auto",
		component_separators = "",
		section_separators = "",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = {
			function()
				local encoding = vim.o.fileencoding
				if encoding == "" then
					return vim.bo.fileformat .. " :: " .. vim.bo.filetype
				else
					return encoding .. " :: " .. vim.bo.fileformat .. " :: " .. vim.bo.filetype
				end
			end,
		},
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- colorscheme
vim.o.background = "dark"
vim.cmd.colorscheme("pywal16")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "Float", { bg = "none" })
vim.cmd(":hi statusline guibg=NONE")
