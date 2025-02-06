#!/bin/bash

# This script backs up Docker Compose files from all projects within a specific directory structure.

# Set the backup directory
backup_dir="$HOME/docker-services"

# Function to handle the backup process
backup_project() {
    local source_dir="$1"
    local dest_dir="$2"
    local project_name="$3"

    echo "Processing backup for: $project_name"

    # Create the backup directory if it doesn't exist
    mkdir -p "$dest_dir" 2>/dev/null

    # Check if a docker-compose.yml file exists in the source directory
    if [ -f "$source_dir/docker-compose.yml" ]; then
        cp "$source_dir/docker-compose.yml" "$dest_dir"
        echo "Copied docker-compose.yml for $project_name."
    else
        echo "No docker-compose.yml found for $project_name."
    fi
}

# Iterate over each found project directory
for dock_dir in $(fdfind . "/omni/apps" -t d -d 1); do
    # Extract the project name from the directory path
    project_name=$(basename "$dock_dir")

    # Check if arr_apps exists within this directory
    if [ "$(basename "$(dirname "$dock_dir")")" = "arr_apps" ]; then
        nested_dirs=$(fdfind . "$dock_dir" -t d -d 1)  # Adjusted to use absolute paths

        # Iterate over each subdirectory and process it
        echo "$nested_dirs" | while read -r nested_dir; do
            nested_project_name=$(basename "$nested_dir")
            backup_project "$nested_dir" "$backup_dir/$project_name/$nested_project_name" "$nested_project_name"
        done

        # Process the main arr_apps directory, ensuring no redundancy by using a conditional check
        if [[ $project_name != "arr_apps" ]]; then
            backup_project "$dock_dir" "$backup_dir/$project_name" "$project_name"
        fi

    else
        # Process standalone projects directly in this directory
        backup_project "$dock_dir" "$backup_dir/$project_name" "$project_name"
    fi
done
