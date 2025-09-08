export DOT_DIR=~/home

# Setup Starship prompt
eval "$(starship init zsh)"

# and point the config to the home directory
export STARSHIP_CONFIG=$DOT_DIR/starship.toml


# Setup FZF key commands
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Setup direnv
eval "$(direnv hook zsh)"

# Setup zoxide
eval "$(zoxide init zsh)"

# mise
eval "$(mise activate zsh)"

export PATH=$HOME/.emacs.d/bin:$PATH
export PATH=$HOME/.config/emacs/bin:$PATH
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/history.zsh
# History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

export PATH=$HOME/.local/scripts/:$PATH

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
