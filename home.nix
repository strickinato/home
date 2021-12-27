{ config, pkgs, lib, ... }:

{
  imports = [
    ./zsh.nix
    ./emacs.nix
    ./qutebrowser.nix
  ];

  programs.home-manager = {
    enable = true;
  };

  programs.bat.enable = true;
  programs.jq.enable = true;
  programs.fzf.enable = true;

  programs.git = {
      enable = true;
      userName = "Aaron Strick";
      userEmail = "aaronstrick@gmail.com";
      extraConfig = {
        hub.protocol = "https";
        github.user = "strickinato";
        color.ui = true;
        credential.helper = "osxkeychain";
      };
      aliases = {
        co = "checkout";
        st = "status";
        lol = "log --decorate --all --graph --oneline";
        l = "log --decorate --all --graph";
        "branch-name" = "!git rev-parse --abbrev-ref HEAD";
        publish = "!git push -u origin $(git branch-name)";
        c = "!git checkout `git branch | fzf`";
      };
    };

  programs.ssh = {
    enable = true;
    extraConfig = "
Host *
  AddKeysToAgent yes
  UseKeychain yes
Host bird
  User strickinato
Host wolf
  User pi
    ";
  };

  home.sessionVariables = {
    LEDGER_FILE = "$HOME/ledger/ledger.journal";
    EDITOR = "vim";
  };

  home.file.".hammerspoon".source = /Users/strickinato/home/services/hammerspoon;

  home.packages = with pkgs; [
    hledger
    hledger-ui
    hledger-web

    direnv
    lorri

    syncthing

    wget
    git
    vim
    entr
    exercism
    fzf
    graphviz
    nmap
    tldr
    zsh
  ];


  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.03";
}
