local assets = vim.fn.stdpath("config") .. "/assets"

vim.g.mkdp_filetypes = { "markdown" }
vim.g.mkdp_markdown_css = assets .. "/md.css"
vim.g.mkdp_highlight_css = assets .. "/mdhl.css"
-- vim.g.mkdp_browser = "/usr/bin/firefox"

vim.keymap.set("n", "<leader>mdn", ":MarkdownPreview<CR>")
vim.keymap.set("n", "<leader>mds", ":MarkdownPreviewStop<CR>")
