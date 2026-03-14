#!/bin/bash

DOT_DIR=~/home
MY_CONFIG_DIR=$DOT_DIR/config

link() { mkdir -p "$(dirname "$2")" && ln -sfn "$1" "$2"; }

brew bundle --file=$DOT_DIR/Brewfile

link $MY_CONFIG_DIR/.zshrc ~/.zshrc
link $MY_CONFIG_DIR/.gitconfig ~/.gitconfig
link $MY_CONFIG_DIR/ssh/config ~/.ssh/config
link $MY_CONFIG_DIR/karabiner.json ~/.config/karabiner/karabiner.json
link $MY_CONFIG_DIR/hammerspoon/init.lua ~/.config/hammerspoon/init.lua

defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"

link $MY_CONFIG_DIR/nvim ~/.config/nvim
link $MY_CONFIG_DIR/tmux ~/.config/tmux
link $MY_CONFIG_DIR/ghostty ~/.config/ghostty
link $MY_CONFIG_DIR/glide/glide.ts ~/.config/glide/glide.ts
link $MY_CONFIG_DIR/emacs-plus/build.yml ~/.config/emacs-plus/build.yml
link $DOT_DIR/scripts ~/.local/scripts



# Setup doom emacs

if [ ! -d ~/.config/emacs ] 
then
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
    link $DOT_DIR/emacs/.doom.d ~/.doom.d
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
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1"


# Remapping capslock to escape
# https://rakhesh.com/mac/using-hidutil-to-map-macos-keyboard-keys/
# https://hidutil-generator.netlify.app/

cp $MY_CONFIG_DIR/com.local.KeyRemapping.plist ~/Library/LaunchAgents/com.local.KeyRemapping.plist
launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.local.KeyRemapping.plist 2>/dev/null
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.local.KeyRemapping.plist

# More miscellaneous ones:
# https://gist.github.com/mbinna/2357277
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# "Expand print panel by default"
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true


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
