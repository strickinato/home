DOT_DIR=~/home
MY_CONFIG_DIR=$DOT_DIR/config

brew bundle --file=$DOT_DIR/Brewfile

mkdir -p ~/.config

ln -s $MY_CONFIG_DIR/.zshrc ~/.zshrc
ln -s $MY_CONFIG_DIR/.gitconfig ~/.gitconfig

ln -s $MY_CONFIG_DIR/ssh/config ~/.ssh/config

mkdir -p ~/.config/karabiner
ln -s $MY_CONFIG_DIR/karabiner.json ~/.config/karabiner/karabiner.json

mkdir -p ~/.config/hammerspoon
ln -s $MY_CONFIG_DIR/hammerspoon/init.lua $HOME/.config/hammerspoon/init.lua
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

ln -s $MY_CONFIG_DIR/nvim $HOME/.config/nvim
ln -s $MY_CONFIG_DIR/tmux $HOME/.config/tmux
ln -s $MY_CONFIG_DIR/ghostty $HOME/.config/ghostty

ln -s $DOT_DIR/scripts ~/.local/scripts


ln -s $MY_CONFIG_DIR/iterm/com.googlecode.iterm2.plist ~/Library/Preferences/com.googlecode.iterm2.plist

# Run the setup for fzf after install
/opt/homebrew/opt/fzf/install

# Setup doom emacs

if [ ! -d ~/.config/emacs ] 
then
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
    ln -s $DOT_DIR/emacs/.doom.d ~/.doom.d
    ~/.config/emacs/bin/doom install
fi


# APPLE DEFAULTS
# https://macos-defaults.com/misc/applepressandholdenabled.html#set-to-true-default-value

defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "tilesize" -int "12" 
defaults write com.apple.dock "static-only" -bool "true"


defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1"u


# Remapping capslock to escape
# https://rakhesh.com/mac/using-hidutil-to-map-macos-keyboard-keys/
# https://hidutil-generator.netlify.app/

cp $MY_CONFIG_DIR/com.local.KeyRemapping.plist ~/Library/LaunchAgents/com.local.KeyRemapping.plist
launchctl load ~/Library/LaunchAgents/com.local.KeyRemapping.plist

# More miscellaneous ones:
# https://gist.github.com/mbinna/2357277
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool truer


# Key Repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 4
defaults write NSGlobalDomain InitialKeyRepeat -int 25

# "Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# "Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

killall Dock
killall Finder
