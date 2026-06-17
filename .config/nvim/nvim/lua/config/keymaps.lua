local map = vim.keymap.set

vim.g.mapleader = " "

-- misc
map('n', '<leader>o', ':update<CR> :source<CR>', { desc = "Reload init" })
map('n', '<leader>w', ':write<CR>', { desc = "Write" })
map('n', '<leader>q', ':quit<CR>', { desc = "Quit" })
map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>', { desc = "Yank to clipboard" })
map({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>', { desc = "Delete to clipboard" })
map({ 'n', 'v', 'x' }, '<leader>s', ':e #<CR>', { desc = "Swap buffer" })
map({ 'n', 'v', 'x' }, '<leader>S', ':sf #<CR>', { desc = "Split swap buffer" })

-- Pickers
map('n', '<leader>ff', ":Pick files<CR>", { desc = "Find files" })
map('n', '<leader>fh', ":Pick help<CR>", { desc = "Find help" })
map('n', '<leader>fz', ":PickZoxide<CR>", { desc = "Find zoxide" })
map('n', '<leader>fw', ":PickFilesCwd<CR>", { desc = "Find in working dir" })
map('n', '<leader>e', ":Oil<CR>", { desc = "Explorer" }) -- file explorer
map("n", "<leader>x", "<cmd>!chmod +x %<CR>")            -- make file executable
map('n', '<leader>?', function()
	require("which-key").show({ global = false })
end, { desc = "Which-key (buffer)" })                           -- show buffer keymaps
map('n', '<leader>lf', vim.lsp.buf.format, { desc = "Format" }) -- format buffer

-- Theme
map("n", "<leader>l", ":Twilight<CR>") -- dim surrounding text
