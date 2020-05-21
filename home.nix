{ config, pkgs, ... }:

let
  relativeXDGDataPath = ".local/share";
in
{
  programs.home-manager.enable = true;

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

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      history = {
        path = "${relativeXDGDataPath}/zsh/.zsh_history";
      };
      defaultKeymap = "viins";

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.6.3";
            sha256 = "1h8h2mz9wpjpymgl2p7pc146c1jgb3dggpvzwm9ln3in336wl95c";
          };
        }
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "be3882aeb054d01f6667facc31522e82f00b5e94";
            sha256 = "0w8x5ilpwx90s2s2y56vbzq92ircmrf0l5x8hz4g1nx3qzawv6af";
          };
        }
      ];
    };
















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
