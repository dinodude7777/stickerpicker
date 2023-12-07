#!/usr/bin/env sh

# Get the directory where the script is located
script_dir=$(dirname "$0")

# Define the path to the Stickers directory relative to the script location
stickers_dir="$script_dir/Stickers"

# Define the path to the web/packs directory relative to the script location
packs_dir="$script_dir/web/packs"

# Check if the Stickers directory exists
if [ -d "$stickers_dir" ]; then
    # Iterate through each subdirectory in Stickers
    for dir in "$stickers_dir"/*; do
        if [ -d "$dir" ]; then
            subdir=$(basename "$dir")
            echo "Processing $subdir..."
            sticker-pack "$stickers_dir/$subdir" --add-to-index "$packs_dir/"
        fi
    done
else
    echo "Stickers directory not found: $stickers_dir"
    exit 1
fi
