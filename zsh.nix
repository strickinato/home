{ pkgs, ... }:

let
  extras = [
    ./zsh/cat_path.zsh
    ./zsh/fgit.zsh
    ./zsh/kill.zsh
    ./zsh/home_manager.zsh
    ./zsh/my_ip.zsh
  ];

  extraInitExtra =
    builtins.foldl' (acc: func: acc + "\n" + builtins.readFile func) ""
    extras;
in {

  # Prompt
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;

    dotDir = ".config/zsh";

    enableAutosuggestions = true;
    enableCompletion = true;

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

    initExtra = ''
      alias ll="ls -la"

      alias ..="cd .."
      alias ...="cd ../.."
      alias ....="cd ../../.."
      alias .....="cd ../../../.."

      eval "$(direnv hook zsh)"

    '' + extraInitExtra;

    history = {
      save = 10000;
      size = 10000;
      share = true;
    };
  };
}
