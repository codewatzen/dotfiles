#!/bin/zsh
# Install Starship
curl -sS https://starship.rs/install.sh | sh

mkdir -p ~/.config/zsh

stow zsh -d dotfiles/ -t

stow -d dotfiles/zsh -t ~/dotfiles/zsh/plugins plugins

# Initialize submodules
git submodule update --init --recursive

echo "Dotfiles setup complete!"
