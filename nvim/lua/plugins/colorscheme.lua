-- catppuccin colorscheme configuration

require("catppuccin").setup({
	flavour = "frappe",
	transparent_background = true,
        styles = {
           sidebars = "transparent",
           floats = "transparent",
        },
})

-- if you want to get rid of toggling and just set one scheme, you can set here
-- local colorscheme = "catppuccin"
-- vim.cmd('silent! colorscheme catppuccin')
