local alpha = require('alpha')
local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
      [[ ⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⣀⠀⡀⢀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀ ]],
      [[ ⣶⣶⣶⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⣽⠃⠀⠀⠀⢼⠻⣿⣿⣟⣿⣿⣿⣿⣶⣶⣶⣶⣤⣤⣤⣤⣤ ]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠀⠀⠛⡶⢶⢺⠁⠀⠈⢿⣿⣿⣿⣿⣿⣿⣏⣿⣿⣿⣿⣿⣿⣿ ]],
      [[ ⣯⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡟⠀⠀⣤⠀⣀⣠⡛⣣⡀⠀⠈⢿⣿⣿⣻⣏⣿⣿⣿⣿⣿⣿⣟⣿⠿ ]],
      [[ ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠃⠀⠀⣳⣶⣿⣿⣷⣾⠱⠀⠀⠊⢿⠿⠿⢛⣽⣿⡿⢿⣿⣟⠿⠿⠿ ]],
      [[ ⠉⠉⠉⠛⠛⠛⠋⠛⠛⠛⣧⠀⡀⠀⠀⢿⣿⣿⡿⠃⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⠅⢀⢀⡀ ]],
      [[ ⠔⠄⢀⡀⠀⠀⠀⠄⠐⠸⠿⡀⠀⠀⠀⢘⣿⢷⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠀⠀⠰⣠⣇ ]],
      [[ ⣷⣆⣴⣮⢻⡲⡲⠀⠁⠀⠀⠀⠀⠀⠀⠹⡿⠘⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⣀⡘⢷⣏ ]],
      [[ ⣿⣿⣿⣗⠿⢈⠁⡀⠀⠁⠀⠀⠀⠀⠀⠀⠉⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠠⢀⠄⠀⠄⠈⢿⣮⢿ ]],
      [[ ⣿⣟⡿⣾⠀⠀⠀⠀⠀⠀⠀⢀⡤⠄⠀⠀⠀⠀⠸⠁⢠⣦⣤⢀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠀⠈⣿⠀ ]],
      [[ ⣿⣿⠏⠁⢀⡇⠀⠀⠀⠀⠀⠀⡄⠀⠀⠀⠘⡏⣷⣵⡻⠃⠄⢴⣆⠀⠀⠀⠀⠀⠀⠀⠰⠀⣆⣷⣿ ]],
      [[ ⣿⡿⣻⠗⠀⢠⠀⠀⠀⠀⠀⠃⠀⠀⠀⠀⢠⣤⣄⢰⣶⢯⣤⡈⠋⠀⠀⠀⠀⠀⠀⠀⠀⠆⠀⣿⣼ ]],
    }
dashboard.section.buttons.val = {
	dashboard.button("f", "λ  > Find file", ":lua require('fzf-lua').files() <CR>"),
	dashboard.button("t", "λ  > Browse cwd", ":NvimTreeOpen<CR>"),
	dashboard.button("r", "λ  > Browse src", ":e ~/.local/src/<CR>"),
	dashboard.button("c", "λ  > Config", ":e ~/.config/nvim/<CR>"),
	dashboard.button("m", "λ  > Mappings", ":e ~/.config/nvim/lua/config/mappings.lua<CR>"),
	dashboard.button("p", "λ  > Plugins", ":PlugInstall<CR>"),
}

dashboard.section.footer.val = {
	[[ -All these bytes will be lost in time- ]],
}

dashboard.section.buttons.opts.hl = "Keyword"
dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
