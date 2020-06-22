{ config, lib, pkgs, ... }:

let
  home-manager = (import <nixpkgs> {}).fetchFromGitHub {
    owner = "rycee";
    repo = "home-manager";
    rev = "dc227b579d71f92e24717dac09bbe3846d5a6597";
    sha256 = "0kdnc78z4pzjjbidr0c7mxfg0518rd1gqay8lchmnr8613fvw39y";
  };
in
{

  users.users.strickinato = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "docker" ]; # Enable ‘sudo’ for the user.
    openssh.authorizedKeys.keys = [
      # hackerbox
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDHxa9ZhOtPnCffGQ1Z1qMYpBK9U6ts9r+HqxqONvR2nz4LXngdA7LpiEMmqj/NntHPaocWAdIxBvC8kQUgk15JDwXS1qKPNnzSOr0JJopzw37zi3osRECW45jQPUhjbzFz3OgB5czALH24Ry61qgCn7EeK/KMMBgUdRmkQEviOXNtLouW29HM73ms8/C4qP9zyKVC0mfIEo/L0pTYLtJ4pgjxe09IShs5a7RxfJ/qF8MYe61NyU775tYdYsSXcIQqA+8tOnXqpMMpIDcvcX9zx9dp4pZjBDs5bZTzOzrjzK8DIrPuZ14g3Dos0XYo6/NDfCxBVHlCn5h6bMrz1aU3F6pRKpeY6jtN+Qt+fxRWY8q1rCzSFUQvgruD1i17HPObkfTiA8MYcvJrfk/dHJxoBCxulPjgvEs8EdgaywdbrKE6ApQTRCS983LE1CJb2BgzRhZ8tbC3C839ets2uqd/tJ0H/GwuxN65JVAo00Y1HZnOhzoAEsdJbaqTZx9AuxdIUgpmG8yC+dOkJA4kagsEh3+QM/ymtYfaiGSs6zJQPjPXRmivGg1m6KIyFIMC0xHgCMMB1W7xc65hGr+og9J0sAxJTnHkYpQVn41CK0Pr3ueIB9vCoopTNmjQTveLbp8JSlUipb1m2kBkIKfwz3GJIMqFg3Iq6wdSPK08pu9lK3w== hackerbox"
    ];
  };

  imports = [
    "${home-manager}/nixos"
  ];


  home-manager.users.strickinato = {
    imports = [ ./home.nix ];

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = [ "sxiv.desktop" ];
        "image/jpeg" = [ "sxiv.desktop" ];
      };
    };
  };

}
