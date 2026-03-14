#!/bin/bash

DOT_DIR=~/home
MY_CONFIG_DIR=$DOT_DIR/config

info() { printf "\033[1;34m==>\033[0m \033[1m%s\033[0m\n" "$1"; }
skip() { printf "\033[1;33m  skipped:\033[0m %s\n" "$1"; }

link() {
  mkdir -p "$(dirname "$2")"
  if [ -L "$2" ] && [ "$(readlink "$2")" = "$1" ]; then
    skip "$2 (already linked)"
  else
    ln -sfn "$1" "$2"
    printf "\033[1;32m  linked:\033[0m %s\n" "$2"
  fi
}

info "Installing Homebrew"
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    skip "Homebrew (already installed)"
fi

info "Installing Homebrew packages"
brew bundle --file=$DOT_DIR/bootstrap/Brewfile

info "Creating symlinks"
link $MY_CONFIG_DIR/zsh/.zshrc ~/.zshrc
link $MY_CONFIG_DIR/git/.gitconfig ~/.gitconfig
link $MY_CONFIG_DIR/ssh/config ~/.ssh/config
link $MY_CONFIG_DIR/karabiner/karabiner.json ~/.config/karabiner/karabiner.json
link $MY_CONFIG_DIR/hammerspoon/init.lua ~/.config/hammerspoon/init.lua
defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
link $MY_CONFIG_DIR/starship/starship.toml ~/.config/starship.toml
link $MY_CONFIG_DIR/ghostty ~/.config/ghostty
link $MY_CONFIG_DIR/glide/glide.ts ~/.config/glide/glide.ts
link $MY_CONFIG_DIR/emacs/emacs-plus/build.yml ~/.config/emacs-plus/build.yml
link $DOT_DIR/scripts ~/.local/scripts

info "Setting up Alfred sync"
defaults write com.runningwithcrayons.Alfred-Preferences syncfolder -string "~/home/config/alfred"

info "Setting up Doom Emacs"
link $MY_CONFIG_DIR/emacs/.doom.d ~/.doom.d
# ln -sfn /usr/local/Cellar/emacs-plus@31/31.0.50/Emacs.app /Applications/Emacs.app
if [ ! -d ~/.config/emacs ]; then
    git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
    ~/.config/emacs/bin/doom install
else
    skip "Doom Emacs (already installed)"
fi

info "Configuring macOS defaults"
# https://macos-defaults.com/misc/applepressandholdenabled.html#set-to-true-default-value
defaults write com.apple.dock "autohide" -bool "true"
defaults write com.apple.dock "tilesize" -int "12"
defaults write com.apple.dock "static-only" -bool "true"
defaults write com.apple.finder "AppleShowAllFiles" -bool "true"
defaults write com.apple.finder "ShowPathbar" -bool "true"
defaults write com.apple.finder "FXPreferredViewStyle" -string "clmv"
defaults write NSGlobalDomain "NSTableViewDefaultSizeMode" -int "1"

# https://gist.github.com/mbinna/2357277
# https://github.com/mathiasbynens/dotfiles/blob/main/.macos
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain KeyRepeat -int 4
defaults write NSGlobalDomain InitialKeyRepeat -int 25
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

info "Setting up capslock-to-escape remap"
# https://rakhesh.com/mac/using-hidutil-to-map-macos-keyboard-keys/
# https://hidutil-generator.netlify.app/
cp $MY_CONFIG_DIR/macos/com.local.KeyRemapping.plist ~/Library/LaunchAgents/com.local.KeyRemapping.plist
launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.local.KeyRemapping.plist 2>/dev/null
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.local.KeyRemapping.plist

info "Restarting Dock and Finder"
killall Dock
killall Finder
