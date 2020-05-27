{ config, pkgs, ... }:

{

  imports = [
    ./zsh.nix
  ];

  programs.home-manager = {
    enable = true;
    path = "$HOME/home";
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
    };


  home.packages = with pkgs; [
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
