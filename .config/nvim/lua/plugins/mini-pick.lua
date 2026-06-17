local pick = require("mini.pick")
local builtin = pick.builtin
local api = vim.api
local fn = vim.fn
local fs = vim.fs

pick.setup()

local function zoxide_items()
	local lines = fn.systemlist({ "zoxide", "query", "-ls" })
	if vim.v.shell_error ~= 0 then
		vim.notify("zoxide not available", vim.log.levels.WARN)
		return {}
	end

	local items = {}
	for _, line in ipairs(lines) do
		local path = line:match("^%S+%s+(.+)$") or line
		if path and path ~= "" then
			table.insert(items, path)
		end
	end
	return items
end

local function pick_zoxide()
	pick.start({
		source = {
			name = "Zoxide",
			items = zoxide_items(),
			choose = function(item)
				if item and item ~= "" then
					vim.cmd("cd " .. fn.fnameescape(item))
				end
			end,
		},
	})
end

local function resolve_working_dir()
	local bufname = api.nvim_buf_get_name(0)
	local dir = bufname ~= "" and fs.dirname(bufname) or ""
	if dir ~= "" then
		dir = fs.root(dir, { ".git" }) or dir
	end
	if dir == "" then
		dir = fn.getcwd()
	end
	if dir == "" or dir == "/" then
		dir = vim.loop.os_homedir()
	end
	return dir
end

local function pick_files_cwd()
	local dir = resolve_working_dir()
	local prev = fn.getcwd()
	vim.cmd("lcd " .. fn.fnameescape(dir))
	api.nvim_create_autocmd("User", {
		pattern = "MiniPickStop",
		once = true,
		callback = function()
			vim.cmd("lcd " .. fn.fnameescape(prev))
		end,
	})
	builtin.files()
end

api.nvim_create_user_command("PickZoxide", pick_zoxide, {})
api.nvim_create_user_command("PickFilesCwd", pick_files_cwd, {})
