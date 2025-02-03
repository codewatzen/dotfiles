#!/bin/zsh
# Install Starship
curl -sS https://starship.rs/install.sh | sh

# Symlink configs
stow zsh bash starship micro bat htop -t ~

# Initialize submodules
git submodule update --init --recursive
