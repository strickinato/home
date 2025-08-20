# strickinatos dotfiles

## About

This setup is meant to help me get myself setup quickly and reproducibly... but actually not really, it's mostly for fun, since I'm not getting new computers very often...

It's nice though to basically have the same setup on my home computer and on my work computer, and these aid in the process.

# Setting up a mac

### Get the stuff
  From a fresh install:

  - After doing all the iCloud stuff
  - Open Terminal
  - `git` -> macOS prompts you to download developer tools
  - `git clone https://github.com/strickinato/home.git`

### Installing apps
  - Download homebrew
    - `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`
    - ~/home/setup-mac.sh

## Emacs setup

## Getting Emacs setup!

I use [doom-emacs](https://github.com/hlissner/doom-emacs).

### Install the application

Most of the prereqs are handled with home-manager.

If you don't already have devtools, probably run `xcode-select --install`


```sh
brew tap d12frosted/emacs-plus
brew install emacs-plus
ln -s /usr/local/opt/emacs-plus/Emacs.app /Applications/Emacs.app
```

### Get doom!

Get my config from this repo:

```sh
ln -s $HOME/home/emacs/.doom.d $HOME/.doom.d

```

and get the actual doom:

``` sh
git clone https://github.com/hlissner/doom-emacs ~/.emacs.d
~/.emacs.d/bin/doom install
```


# Notable dots

Th0rgal/horus-nix-home
https://github.com/utdemir/dotfiles
https://github.com/ghuntley/dotfiles-nixos
https://github.com/peel/dotfiles
https://github.com/tmplt/nixos-config
https://github.com/search?q=nixfiles

