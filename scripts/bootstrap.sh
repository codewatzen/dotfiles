#!/bin/zsh

# Function to check and create required directories
dir_check() {
    dirs=(
        "$HOME/.config/zsh/plugins/"
        "$HOME/.config/functions"
        "$HOME/.config/scripts"
        "$HOME/.config/micro"
    )

    for dir in "$dirs[@]"; do
        if [[ ! -d "$dir" ]]; then
            echo "Creating missing directory: $dir"
            mkdir -p "$dir" && echo "Created: $dir"
        else
            echo "Directory exists: $dir"
        fi
    done
}

# Function to check and backup existing dotfiles
dotfiles_check() {
    files=(
        "$HOME/.zshrc"
        "$HOME/.bashrc"
        "$HOME/.config/.aliasrc"
        "$HOME/.config/.starship.toml"
        "$HOME/.config/scripts/bootstrap.sh"
        "$HOME/.config/micro/bindings.json"
        "$HOME/.config/functions/.funcsrc"
    )
    
    for file in "$files[@]"; do 
        if [[ -f "$file" ]]; then 
            mv "$file" "$file.bak"
            echo "Backed up: $file -> $file.bak"
        else
            echo "No existing file to backup: $file"
        fi
    done
}

# Execute directory and dotfiles checks
dir_check
dotfiles_check

# Stow (symlink) dotfiles to their target locations
stow_configs() {
    stow zsh -d dotfiles/ -t ~
    stow -d dotfiles/zsh -t ~/dotfiles/zsh/plugins plugins
    stow functions -d dotfiles/ -t ~/.config/functions
    stow scripts -d dotfiles/ -t ~/.config/scripts/
    stow alias -d dotfiles/ -t ~/.config/
    stow micro -d dotfiles/ -t ~/.config/micro/
}

stow_configs

# Install Starship prompt if not already installed
if ! command -v starship &>/dev/null; then
    echo "Installing Starship..."
    curl -sS https://starship.rs/install.sh | sh
else
    echo "Starship is already installed."
fi

# Initialize Git submodules
echo "Initializing Git submodules..."
git submodule update --init --recursive

echo "Dotfiles setup complete!"
