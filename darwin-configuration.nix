{ config, pkgs, ... }:

{
  # Use home manager to manage things
  imports = [ <home-manager/nix-darwin> ];

  home-manager.useUserPackages = true;
  home-manager.users = {
    strickinato = {
      imports = [ ./home.nix ];
      
      # TODO Move to a profile
      home.file.".config/yabai/yabairc" = {
        source = ./yabairc;
      };
      home.file.".config/skhd/skhdrc" = {
        source = ./skhdrc;
      };
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
    { home-manager = "$HOME/.nix-defexpr/channels/home-manager/"; }
    { darwin = "$HOME/.nix-defexpr/channels/darwin/"; }
    { pkgs = "$HOME/.nix-defexpr/channels/pkgs/"; }
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

      KeyRepeat = 1;
      InitialKeyRepeat = 10;
      
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
  
  # TODO Setup the dotfiles
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
  };
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
