export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$HOME/go/bin:/usr/local/opt/llvm/bin:/Library/TeX/texbin:$HOME/.config/rofi/scripts:$PATH"

export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  nvm
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-bat
)

source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

autoload -U colors && colors
bindkey -e
unsetopt BEEP
PS1="%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}λ%b "

source <(fzf --zsh) 
finder() {
	open . 
}
zle -N finder 
bindkey '^f' finder
_comp_options+=(globdots)

export EDITOR='nvim'
export CHROME_EXECUTABLE=/usr/bin/chromium 
