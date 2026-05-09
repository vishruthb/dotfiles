# dotfiles

Personal dotfiles for easier migration.

## Structure

```
shell/       → .zshrc, .zshenv, .bashrc, .bash_profile, .profile
git/         → .gitconfig, .gitignore, global gitignore
editor/      → .vimrc, nvim config, starship.toml
warp/        → Warp themes, keybindings, settings
ghostty/     → Ghostty terminal config
iterm2/      → iTerm2 config
gh/          → GitHub CLI config
fish/        → Fish shell config
```

## Restore on a new machine

```bash
# Clone and symlink (adjust paths as needed)
git clone <repo-url> ~/dotfiles

# Shell
ln -sf ~/dotfiles/shell/zshrc ~/.zshrc
ln -sf ~/dotfiles/shell/zshenv ~/.zshenv
ln -sf ~/dotfiles/shell/bashrc ~/.bashrc
ln -sf ~/dotfiles/shell/bash_profile ~/.bash_profile
ln -sf ~/dotfiles/shell/profile ~/.profile

# Git
ln -sf ~/dotfiles/git/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/gitignore ~/.gitignore
ln -sf ~/dotfiles/git/gitignore_global ~/.config/git/ignore

# Editor
ln -sf ~/dotfiles/editor/vimrc ~/.vimrc
ln -sf ~/dotfiles/editor/nvim ~/.config/nvim
ln -sf ~/dotfiles/editor/starship.toml ~/.config/starship.toml

# Warp
ln -sf ~/dotfiles/warp/keybindings.yaml ~/.warp/keybindings.yaml
ln -sf ~/dotfiles/warp/settings.toml ~/.warp/settings.toml
cp -R ~/dotfiles/warp/themes ~/.warp/themes

# Ghostty
ln -sf ~/dotfiles/ghostty ~/.config/ghostty

# Or just run the setup script
bash setup.sh
```
