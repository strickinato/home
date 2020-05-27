# kill processes easily

rebuild_nix() {
    home-manager switch -f $HOME/home/home.nix -I $HOME/.nix-defexpr/channels
}

alias switch=rebuild_nix
