-- Based Nvim config

-- opt
require("config.options")

-- native plugin manager 
vim.pack.add({
	{ src = "https://github.com/folke/twilight.nvim" }, -- dim inactive code
	{ src = "https://github.com/wnkz/monoglow.nvim" }, -- monochrome colorscheme
	{ src = "https://github.com/e-ink-colorscheme/e-ink.nvim" }, -- eink colorscheme
	{ src = "https://github.com/nvim-mini/mini.pick" }, -- fuzzy finder
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" }, -- treesitter highlighting
	{ src = "https://github.com/nordtheme/vim" }, -- nord colorscheme
	{ src = "https://github.com/stevearc/oil.nvim" }, -- file explorer
	{ src = "https://github.com/chomosuke/typst-preview.nvim" }, -- typst preview
	{ src = "https://github.com/mason-org/mason.nvim" }, -- LSP installer
	{ src = "https://github.com/neovim/nvim-lspconfig" }, -- LSP configs
	{ src = "https://github.com/hrsh7th/nvim-cmp" }, -- completion
	{ src = "https://github.com/hrsh7th/cmp-nvim-lsp" }, -- LSP completion source
	{ src = "https://github.com/L3MON4D3/LuaSnip" }, -- snippets
	{ src = "https://github.com/saadparwaiz1/cmp_luasnip" }, -- snippet completion source
	{ src = "https://github.com/windwp/nvim-autopairs" }, -- auto pairs
	{ src = "https://github.com/folke/which-key.nvim" }, -- keymap hints
	{ src = "https://github.com/numToStr/Comment.nvim" }, -- comment toggles
	{ src = "https://github.com/lewis6991/gitsigns.nvim" }, -- git signs
	{ src = "https://github.com/nvim-lualine/lualine.nvim" }, -- statusline
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- file icons
	{ src = "https://github.com/norcalli/nvim-colorizer.lua" }, -- css color
	{ src = "https://github.com/mfussenegger/nvim-lint" }, -- linting
	{ src = "https://github.com/iamcco/markdown-preview.nvim", build = "cd app && yarn install" } -- markdown preview
})

-- keymaps
require("config.keymaps")

-- plugins
require("plugins.mason")
require("plugins.treesitter")
require("plugins.oil")
require("plugins.comment")
require("plugins.gitsigns")
require("plugins.which-key")
require("plugins.mini-pick")
require("plugins.lsp")
require("plugins.cmp")
require("plugins.lint")
require("plugins.twilight")
require("plugins.lualine")
require("plugins.colorizer")
require("plugins.markdown-preview")
-- colorscheme
require("theme.colorscheme")
