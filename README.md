# strickinatos dotfiles

## About

This setup is meant to help me get myself setup quickly and reproducibly... but actually not really, it's mostly for fun, since I'm not getting new computers very often...

It's nice though to basically have the same setup on my home computer and on my work computer, and these aid in the process.

# Dev setup

Clone this repo into the home directory

``` sh

git clone git@github.com:strickinato/home.git`

```

# Nix stuff

For this, I use [home-manager](https://github.com/rycee/home-manager/), so it looks something like this:

### Install Nix

Follow [their instructions](https://nixos.org/nix/manual/#ch-installing-binary):

``` sh
sh <(curl https://nixos.org/nix/install) --daemon
```

### Then install home-manager

Follow [their instructions](https://github.com/rycee/home-manager/#installation)

``` sh
nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager
nix-channel --update

```

``` sh
nix-shell '<home-manager>' -A install
```

### Make it happen!

The setup includes a helper `switch` that updates things once it's all installed, but the first time, that doesn't exist so run:

``` sh
home-manager switch -f ~/home/home.nix -I $HOME/.nix-defexpr/channels
```

## Getting Emacs setup!

I use [doom-emacs](https://github.com/hlissner/doom-emacs). I am not sure an elegant way to get nix to handle all of this.

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


# Rebuilding

`switch`

See `zsh/home_manager.zsh`


# Helpful stuff

``` sh
nix-shell -p ruby pry
```
