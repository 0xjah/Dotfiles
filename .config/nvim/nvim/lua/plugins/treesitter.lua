require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"svelte",
		"typescript",
		"javascript",
		"css",
		"markdown",
		"markdown_inline",
	},
	highlight = { enable = true },
})
