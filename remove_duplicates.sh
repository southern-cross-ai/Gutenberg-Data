#!/bin/bash

# Set the base directory
BASE_DIR="/home/remote/u1138167/Gutenberg-Data/Data"

# Move to the base directory
cd "$BASE_DIR" || exit

# Loop through each subfolder in the base directory
for subfolder in "$BASE_DIR"/*; do
  if [ -d "$subfolder" ]; then
    echo "Processing $subfolder..."
    # Move all files from the subfolder to the base directory
    mv "$subfolder"/* "$BASE_DIR"/
    # Remove the empty subfolder
    rmdir "$subfolder"
    echo "$subfolder removed."
  fi
done

echo "All files have been moved to $BASE_DIR and subfolders have been removed."

