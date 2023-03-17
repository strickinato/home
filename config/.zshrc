export DOTDIR=~/home

# Setup Starship prompt
eval "$(starship init zsh)"

# and point the config to the home directory
export STARSHIP_CONFIG=$DOT_DIR/starship.toml


# Setup FZF key commands
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup direnv
eval "$(direnv hook zsh)"

export PATH=$HOME/.emacs.d/bin:$PATH
export PATH=$HOME/.config/emacs/bin:$PATH
