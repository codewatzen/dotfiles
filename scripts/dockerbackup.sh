#!/usr/bin/env zsh

# Docker Compose Backup Script
# Backs up docker-compose.yml files from ~/docker to ~/docker-services,
# preserving the original directory structure. Uses fd for efficient directory
# scanning and handles special characters in filenames. This script was 
# improved, optimized and commented by Deepseek R1

# Exit on errors, unset variables, and pipe failures
set -euo pipefail

# Check for required fd/fdfind command
if ! command -v fd &>/dev/null && ! command -v fdfind &>/dev/null; then
    echo "Error: This script requires fd (install as 'fd' or 'fdfind')" >&2
    exit 1
fi

# Set the appropriate command name for fd
FD_CMD=$(command -v fd || command -v fdfind)

# Configure directories
SOURCE_DIR="$HOME/docker"
BACKUP_DIR="$HOME/docker-services"

echo "Starting Docker Compose backup from ${SOURCE_DIR} to ${BACKUP_DIR}"

# Find all directories using fd (null-delimited for safe parsing)
while IFS= read -r -d '' relative_path; do
    # Construct full paths for source and backup locations
    source_project="$SOURCE_DIR/$relative_path"
    backup_project="$BACKUP_DIR/$relative_path"
    
    # Create backup directory (no error if exists)
    mkdir -p "$backup_project"
    
    # Define compose file path
    compose_file="$source_project/docker-compose.yml"
    
    # Copy if compose file exists
    if [[ -f "$compose_file" ]]; then
        echo "Backing up: $relative_path"
        cp -f "$compose_file" "$backup_project/"
    else
        echo "Warning: docker-compose.yml missing in $relative_path" >&2
    fi

done < <("$FD_CMD" --type d --base-directory "$SOURCE_DIR" \
        --hidden --no-ignore --print0)

echo "Backup completed successfully to ${BACKUP_DIR}"
