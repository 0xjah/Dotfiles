# ------------------------------
# PATH
# ------------------------------

# Start with system paths
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# Add user paths
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.4.0/bin:$PATH"

# Dev tools
export PATH="$HOME/.cargo/bin:$HOME/go/bin:/usr/local/opt/llvm/bin:/Library/TeX/texbin:$PATH"

# Scripts
export PATH="$HOME/.config/rofi/scripts:$PATH"

# ------------------------------
# Oh My Zsh
# ------------------------------
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  nvm
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-bat
)

source $ZSH/oh-my-zsh.sh

# ------------------------------
# Extra Tools
# ------------------------------
eval "$(zoxide init zsh)"

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && \
  source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"

autoload -U colors && colors
bindkey -e
unsetopt BEEP

# Prompt
PS1="%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}λ%b "

# FZF
source <(fzf --zsh)

# Finder function
finder() { open . }
zle -N finder
bindkey '^f' finder

# Completion: include dotfiles
_comp_options+=(globdots)

# Editor
export EDITOR="nvim"

# Chromium for Puppeteer/Playwright
export CHROME_EXECUTABLE="/usr/bin/chromium"
