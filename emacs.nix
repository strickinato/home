{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # This basically just gets some dependencies for doom-emacs
    # which is sadly not managed by nix
    ripgrep
    coreutils
    fd
  ];
}
