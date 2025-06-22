--useful stuff

-- close nvim-tree if it's last buffer open
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		if #vim.api.nvim_list_bufs() == 1 and vim.bo.filetype == "NvimTree" then
	vim.cmd("quit")
	end
	end,
})


-- auto-create missing dirs when saving a file
--vim.api.nvim_create_autocmd("BufWritePre", {
--	pattern = "*",
--	callback = function()
--	local dir = vim.fn.expand("<afile>:p:h")
--	if vim.fn.isdirectory(dir) == 0 then
--		vim.fn.mkdir(dir, "p")
--	end
--end,
--})


-- linting when file is written to
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    -- try_lint without arguments runs the linters defined in `linters_by_ft`
    -- for the current filetype, on write
    require("lint").try_lint()
  end,
})


-- spellcheck in md
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	command = "setlocal spell wrap",
})


-- disable automatic comment on newline
vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
		end,
})


-- highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
	vim.highlight.on_yank({ timeout = 300 })
	end,
})


-- reload files on external change
--vim.api.nvim_create_autocmd("FocusGained", {
--	pattern = "*",
--	command = "checktime",
--})


-- restore cursor pos on file open
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
	local line = vim.fn.line("'\"")
	if line > 1 and line <= vim.fn.line("$") then
		vim.cmd("normal! g'\"")
	end
end,
})
