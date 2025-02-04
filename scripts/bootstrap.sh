#!/bin/zsh
# Install Starship
curl -sS https://starship.rs/install.sh | sh

mkdir -p ~/.config/zsh

mkdir -p ~/.config/functions

mkdir -p ~/.config/scripts

stow zsh -d dotfiles/ -t

stow -d dotfiles/zsh -t ~/dotfiles/zsh/plugins plugins

stow functions -d dotfiles/ -t ~/.config/functions

stow scripts -d dotfiles/ -t ~/.config/scripts/

stow alias -d dotfiles/ -t ~/.config/

# Initialize submodules
git submodule update --init --recursive

echo "Dotfiles setup complete!"
