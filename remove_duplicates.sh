#!/bin/bash

# Directories
HTML_DIR="./Data/html_files"
TXT_DIR="./Data/txt_files"

# Loop through each HTML file
for html_file in "$HTML_DIR"/*.html; do
  # Get the base name of the HTML file (without the directory and extension)
  base_name=$(basename "$html_file" .html)

  # Check if a corresponding TXT file exists
  if [ -f "$TXT_DIR/$base_name.txt" ]; then
    # Remove the TXT file
    rm "$TXT_DIR/$base_name.txt"
    echo "Removed: $TXT_DIR/$base_name.txt"
  fi
done
