#!/bin/bash
# Dotfiles setup script — run this on a new machine after cloning the repo.
# Usage: cd ~/dotfiles && bash setup.sh

set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

info()  { echo -e "\033[1;34m→\033[0m $1"; }
ok()    { echo -e "\033[1;32m✓\033[0m $1"; }
warn()  { echo -e "\033[1;33m⚠\033[0m $1"; }

link() {
  local src="$DOTFILES/$1"
  local dest="$HOME/$2"

  if [ ! -e "$src" ]; then
    warn "Source missing: $src"
    return
  fi

  mkdir -p "$(dirname "$dest")"

  if [ -L "$dest" ]; then
    local current
    current="$(readlink "$dest")"
    if [ "$current" = "$src" ]; then
      ok "$2 already linked"
      return
    fi
    warn "$2 exists as symlink → $current (replacing)"
    rm "$dest"
  elif [ -e "$dest" ]; then
    warn "$2 exists (backing up to ${dest}.bak)"
    mv "$dest" "${dest}.bak"
  fi

  ln -sf "$src" "$dest"
  ok "linked $2 → $1"
}

# ── Shell ────────────────────────────────────────────────────────────
info "Setting up shell configs..."
link shell/zshrc        .zshrc
link shell/zshenv       .zshenv
link shell/bashrc       .bashrc
link shell/bash_profile .bash_profile
link shell/profile      .profile

# ── Git ──────────────────────────────────────────────────────────────
info "Setting up git configs..."
link git/gitconfig       .gitconfig
link git/gitignore       .gitignore
link git/gitignore_global .config/git/ignore

# ── Editor
info "Setting up editor configs..."
link editor/vimrc         .vimrc
link editor/nvim          .config/nvim
link editor/starship.toml .config/starship.toml

# ── Warp ─────────────────────────────────────────────────────────────
info "Setting up Warp configs..."
mkdir -p "$HOME/.warp"
link warp/keybindings.yaml .warp/keybindings.yaml
link warp/settings.toml    .warp/settings.toml

# Themes are copied (not symlinked) since Warp may modify them
if [ -d "$DOTFILES/warp/themes" ]; then
  cp -R "$DOTFILES/warp/themes" "$HOME/.warp/themes"
  ok "copied warp/themes"
fi

# ── Ghostty ──────────────────────────────────────────────────────────
info "Setting up Ghostty config..."
if [ -d "$DOTFILES/ghostty" ]; then
  link ghostty .config/ghostty
fi

# ── iTerm2 ───────────────────────────────────────────────────────────
info "Setting up iTerm2 config..."
if [ -d "$DOTFILES/iterm2" ]; then
  link iterm2 .config/iterm2
fi

# ── GitHub CLI ────────────────────────────────────────────────────────
info "Setting up GitHub CLI config..."
if [ -d "$DOTFILES/gh" ]; then
  link gh .config/gh
fi

# ── Fish ─────────────────────────────────────────────────────────────
info "Setting up Fish shell config..."
if [ -d "$DOTFILES/fish" ]; then
  link fish .config/fish
fi

# ── Done ─────────────────────────────────────────────────────────────
echo ""
echo -e "\033[1;36mSetup complete!\033[0m"
echo "Don't forget to:"
echo "  1. Restart your shell (or run: source ~/.zshrc)"
echo "  2. Install tools referenced in your configs (starship, etc.)"
