if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export CHROME_EXECUTABLE=/usr/bin/chromium
export PATH=$HOME/.config/rofi/scripts:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k" 

plugins=(
  git
  nvm
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-bat
)

source $ZSH/oh-my-zsh.sh

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

export EDITOR='nvim'

alias serve="python3 -m http.server 8000"
alias sniff="sudo tcpdump -i any"
alias ports="sudo lsof -i -P -n | grep LISTEN"
alias myip="curl ifconfig.me"
alias ipinfo="curl ipinfo.io"
alias ngrok="~/ngrok"
alias reload="source ~/.zshrc"
alias nrun="npm run"
alias gcl="git clone"
alias recon="amass enum -passive -d"
alias rustscan="rustscan -a"
alias sqlmap="python3 ~/tools/sqlmap/sqlmap.py"
alias subz="subfinder -d"
alias ffuf="ffuf -u"
alias dev="cd ~/dev"
alias web="cd ~/dev/web"
alias hack="cd ~/tools"
alias v="nvim"
alias vz="nvim ~/.zshrc"
alias vp="nvim ~/.p10k.zsh"
alias va="nvim ~/.config/nvim/init.lua"
alias vn="nvim ~/notes.md"
alias vhosts="sudo nvim /etc/hosts"
alias venv="nvim .env"
alias server="python3 -m http.server 8080"
unsetopt BEEP
