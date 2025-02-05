# dotfiles
This repository contains all of my dotfiles. The `zshrc` and `aliasrc` are a compilation of resources found across the internet, original configurations I created, or ones pulled from ChatGPT/DeepSeek. AI was used to help format and comment on the files. Additionally, a `bootstrap.sh` script is included in the `scripts` directory to automate setup.

## Features
- Creates necessary directories in `~/.config`
- Backs up existing configuration files (appending `.bak` to filenames)
- Symlinks dotfiles using GNU Stow
- Installs Starship prompt if not already installed
- Initializes and updates Git submodules

## Dependencies 
Ensure the following dependencies are installed before running the bootstrap script:

1. **Zsh**
   - You should also make Zsh your default shell:
     ```sh
     chsh -s $(which zsh)
     ```
2. **Stow** (for managing symlinks)
3. **Micro** (optional, required if using the keybinding file)

## Usage
1. Clone the repository:
   ```sh
   git clone https://github.com/codewatzen/dotfiles.git
   ```
2. Make the bootstrap script executable:
   ```sh
   chmod u+x dotfiles/scripts/bootstrap.sh
   ```
3. Run the bootstrap script:
   ```sh
   ./dotfiles/scripts/bootstrap.sh
   ```

## Components Overview
- **Zsh**: Configuration with plugin support
- **Starship**: Cross-shell prompt
- **Micro**: Editor keybindings
- **Scripts**: Collection of useful shell scripts
- **Functions**: Shell utility functions
- **Aliases**: Common command shortcuts
