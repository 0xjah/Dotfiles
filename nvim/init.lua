-- bread's neovim config
-- keymaps are in lua/config/mappings.lua
-- install a patched font & ensure your terminal supports glyphs
-- enjoy :D

-- auto install vim-plug and plugins, if not found
local data_dir = vim.fn.stdpath('data')
if vim.fn.empty(vim.fn.glob(data_dir .. '/site/autoload/plug.vim')) == 1 then
	vim.cmd('silent !curl -fLo ' .. data_dir .. '/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
	vim.o.runtimepath = vim.o.runtimepath
	vim.cmd('autocmd VimEnter * PlugInstall --sync | source $MYVIMRC')
end

local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('catppuccin/nvim', { ['as'] = 'catppuccin' }) --colorscheme
Plug('uZer/pywal16.nvim', { [ 'as' ] = 'pywal16' }) --or, pywal colorscheme
Plug('nvim-lualine/lualine.nvim') --statusline
Plug('nvim-tree/nvim-web-devicons') --pretty icons
Plug('folke/which-key.nvim') --mappings popup
Plug('romgrk/barbar.nvim') --bufferline
Plug('goolord/alpha-nvim') --pretty startup
Plug('nvim-treesitter/nvim-treesitter') --improved syntax
Plug('mfussenegger/nvim-lint') --async linter
Plug('nvim-tree/nvim-tree.lua') --file explorer
Plug('windwp/nvim-autopairs') --autopairs 
Plug('lewis6991/gitsigns.nvim') --git
Plug('numToStr/Comment.nvim') --easier comments
Plug('norcalli/nvim-colorizer.lua') --color highlight
Plug('ibhagwan/fzf-lua') --fuzzy finder and grep
Plug('numToStr/FTerm.nvim') --floating terminal

vim.call('plug#end')

-- move config and plugin config to alternate files
require("config.theme")
require("config.mappings")
require("config.options")
require("config.autocmd")

require("plugins.alpha")
require("plugins.autopairs")
require("plugins.barbar")
require("plugins.colorizer")
require("plugins.colorscheme")
require("plugins.comment")
require("plugins.fterm")
require("plugins.fzf-lua")
require("plugins.gitsigns")
require("plugins.lualine")
require("plugins.nvim-lint")
require("plugins.nvim-tree")
require("plugins.treesitter")
require("plugins.which-key")

load_theme()

-- ~/.config/nvim
-- ├── init.lua
-- └── lua
--     ├── config
--     │   ├── autocmd.lua
--     │   ├── mappings.lua
--     │   ├── options.lua
--     │   ├── saved_theme
--     │   └── theme.lua
--     └── plugins
--         ├── alpha.lua
--         ├── autopairs.lua
--         ├── barbar.lua
--         ├── colorizer.lua
--         ├── colorscheme.lua
--         ├── comment.lua
--         ├── fterm.lua
--         ├── fzf-lua.lua
--         ├── gitsigns.lua
--         ├── lualine.lua
--         ├── nvim-lint.lua
--         ├── nvim-tree.lua
--         ├── treesitter.lua
--         └── which-key.lua
