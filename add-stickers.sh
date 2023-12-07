#!/usr/bin/env sh

# Get the directory where the script is located
script_dir=$(dirname "$0")
cd "$script_dir" || exit

# Create and activate the Python virtual environment
python3 -m venv "$script_dir/.venv"
"$script_dir/.venv/bin/pip" install -r requirements.txt  # Replace with your requirements file if needed

# Define the path to the Stickers directory relative to the script location
stickers_dir="$script_dir/Stickers"

# Define the path to the web/packs directory relative to the script location
packs_dir="$script_dir/web/packs"

# Full path to the sticker-pack command within the virtual environment
sticker_pack_command="$script_dir/.venv/bin/sticker-pack"

# Execute Python code within the virtual environment
"$script_dir/.venv/bin/python" - <<EOF "$stickers_dir" "$packs_dir" "$sticker_pack_command"
import sys
import subprocess

# Check if the directories are provided
if len(sys.argv) != 4:
  print("Usage: script_name.py <stickers_dir> <packs_dir> <sticker_pack_command>")
  sys.exit(1)

stickers_dir = sys.argv[1]
packs_dir = sys.argv[2]
sticker_pack_command = sys.argv[3]

# Iterate through each subdirectory in Stickers
try:
  for dir in subprocess.check_output(["ls", stickers_dir], text=True).splitlines():
    subdir = dir.strip()
    print(f"Processing {subdir}...")
    subprocess.run([sticker_pack_command, f"{stickers_dir}/{subdir}", "--add-to-index", packs_dir])
except subprocess.CalledProcessError as e:
  print(f"An error occurred: {e}")
  sys.exit(1)
EOF
