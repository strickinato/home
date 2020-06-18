{ config, lib, pkgs, ... }:

{
  time.timeZone = "America/Los_Angeles";

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    displayManager = {
       lightdm = {
         enable = true;
         greeters.mini = {
           enable = true;
           extraConfig = ''
             [greeter]
             user = strickinato
             invalid-password-text = nope
             password-alignment = left
             password-label-text = butt

             [greeter-theme]
             font-size = 10px
             background-color = "#000000"
             text-color = "#00FF00"
             window-color = "#000000"
             border-color = "#00FF00"
             border-width = 2px
             password-border-width = 0


           '';
         };
       };
    };

    windowManager.dwm = { 
      enable = true;
    };
  };

  services.xserver.layout = "us";
  services.xserver.xkbOptions = "caps:escape";

  environment.systemPackages = with pkgs; [
    # Utilities
    wget
    vim
    git
    ranger
    sxiv

    # System
    rofi
    dmenu
    dwm
    st
    alacritty
    emacs

    # Applications
    qutebrowser
    zulip
    bitwarden
    slack
  ];
}
