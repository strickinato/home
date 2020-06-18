{ config, lib, pkgs, ... }:

{
  imports = [
    ./nixos-common.nix
    ../services/dropbox.nix
    ../strickinato.nix
  ];

  networking.hostName = "hackerbox"; # Define your hostname.

  nixpkgs.config.allowUnfree = true;

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.efiInstallAsRemovable = true;

  boot.loader.grub.device = "nodev"; # or "nodev" for efi only
  boot.loader.systemd-boot.enable = true;

  # TODO secret (sorta)
  networking.wireless.enable = true;
  networking.wireless.networks = {
   "friends and lovers" = { psk = "<secret>"; };
  };

  # Enable sound.
  # TODO Could be a shared sound profile
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support.
  # TODO Is this thinkpad specific?
  services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # TODO Is this necessary with home manager?
  users.users.strickinato = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  ####### 
  ####### 
  ####### 
  ####### 
  ####### 
  ####### 
  ####### 
  ####### 
  ####### 
  ####### 
  ####### Just do:
  
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s25.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
