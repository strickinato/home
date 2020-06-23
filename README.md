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
    - `brew bundle --file=Brewfile`

### Install nix

  - macos catalina:
    - https://nixos.org/nix/manual/#sect-macos-installation
    - NOTE: It's a horrible experience on macos catalina, and it seems a lot of people fight about it
      - Here's some reasonable discussion:
        - https://discourse.nixos.org/t/current-status-of-nix-on-macos-catalina/4286/10
        - THIS is what worked for me: https://github.com/NixOS/nix/issues/2925#issuecomment-539570232
  - At some point later I had to `sudo chown -R root /nix/var/nix/db`
  - AND bring darwin back into the path TODO...

### Install nix-darwin:

  - `nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer`
  - `./result/bin/darwin-installer`
    - Note - don't edit the example, because I just copy my own over from this repo
    - I say yes to everything else (bashrc, zshrc, create /run)
  - For the initial switch, point it to the right place
    - `darwin-rebuild switch -I darwin-config=$HOME/home/darwin-configuration.nix`
  
### Have home-manager channel added
  - `nix-channel --add https://github.com/rycee/home-manager/archive/master.tar.gz home-manager`
  - `nix-channel --update`

### For whatever reason, this weirdness:
```

sudo darwin-rebuild switch \
  -I darwin-config=/Users/strickinato/home/darwin-configuration.nix \
  -I darwin=/Users/strickinato/.nix-defexpr/channels/darwin/ \
  -I nixpkgs=/Users/strickinato/.nix-defexpr/channels/nixpkgs/ \
  -I home-manager=/Users/strickinato/.nix-defexpr/channels/home-manager/

```



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

# Setting up the apps

### Using brew and the Brewfile

[From their site](https://brew.sh)

``` sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

cd $HOME
brew bundle

```



# Other things
###  Setting up ledger

Expects a ~/ledger folder that has the prices, rules, and journal files, so symlink this in from dropbox for now


# On NIXOS

ln -s `pwd` ~/.config/nixpkgs


# Notable dots

Th0rgal/horus-nix-home
https://github.com/utdemir/dotfiles
https://github.com/ghuntley/dotfiles-nixos
https://github.com/peel/dotfiles
https://github.com/tmplt/nixos-config
https://github.com/search?q=nixfiles


# TODO
 * Why isn't the qutebrowser config caryring over?


# APF File Sharing

### Resources
http://netatalk.sourceforge.net/3.1/htmldocs/afp.conf.5.html
https://jarmac.org/category/nixos.html
