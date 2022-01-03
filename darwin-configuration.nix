{ config, pkgs, ... }:

{
  # Use home manager to manage things
  imports = [ <home-manager/nix-darwin> ];

  nix.useDaemon = true;

  home-manager.useUserPackages = true;
  home-manager.users = {
    strickinato = {
      imports = [ ./home.nix ];
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = [ pkgs.fira-code pkgs.dejavu_fonts ];
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/home/darwin-configuration.ni
  environment.darwinConfig = "$HOME/home/darwin-configuration.nix";
  nix.nixPath = [
    "darwin-config=$HOME/home/darwin-configuration.nix"
    "darwin=$HOME/.nix-defexpr/channels/darwin"
    "$HOME/.nix-defexpr/channels"
  ];

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  system.defaults = {
    dock = { 
      autohide = true;
      mru-spaces = false;
      showhidden = true;
      static-only = true;
      tilesize = 16;
    };

    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowScrollBars = "Always";
      NSNavPanelExpandedStateForSaveMode = true;

      # Finder sidebar icons
      NSTableViewDefaultSizeMode = 1;
      
      _HIHideMenuBar = true;

      KeyRepeat = 2;
      InitialKeyRepeat = 25;
      
      #volume feedback
      "com.apple.sound.beep.feedback" = 1;
    };

    finder = {
      _FXShowPosixPathInTitle = true;
    };

    screencapture.location = "$HOME/screenshots";
  };

  system.keyboard.enableKeyMapping = true;
  system.keyboard.remapCapsLockToEscape = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
