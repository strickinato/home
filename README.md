# strickinato's dotfiles

## About

Dotfiles and setup scripts for my Mac. Keeps my home and work machines in sync.

## Setting up a new Mac

From a fresh install:

1. Do the iCloud stuff
2. Open Terminal
3. `git` — macOS prompts you to install developer tools
4. Clone and run:
   ```sh
   git clone https://github.com/strickinato/home.git ~/home
   bash ~/home/bootstrap/setup-mac.sh
   ```

This handles Homebrew, packages, symlinks, Doom Emacs, macOS defaults, and key remapping.

## Structure

```
bootstrap/     Setup script and Brewfile
config/        App configs (emacs, git, ghostty, zsh, etc.)
scripts/       Utility scripts (~/.local/scripts)
```

## Notes

- SSH config includes `~/.ssh/local.config` for machine-specific keys (not in repo)
- `.gitconfig` uses `includeIf` for work/personal email switching
- Doom Emacs config lives in `config/emacs/.doom.d`
