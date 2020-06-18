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
