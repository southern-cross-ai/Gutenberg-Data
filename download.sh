#!/bin/bash

URL="https://archive.ics.uci.edu/static/public/239/legal+case+reports.zip"

# Check if the correct number of arguments is provided
if [ "$#" -gt 1 ]; then
    echo "Usage: $0 [<save_path>]"
    exit 1
fi

create_parent_directories() {
    local path="$1"
    local dir="${path%/*}"
    if [ ! -d "$dir" ]; then
        echo "Creating parent directories: $dir"
        /bin/mkdir -p "$dir"
    fi
}

SAVE_PATH=$1
if [ -z "SAVE_PATH" ]; then
    echo "No save path provided. Saving to current directory."
    FULL_PATH="legal_case_reports.zip"
else
    create_parent_directories "$SAVE_PATH"
    FULL_PATH="$SAVE_PATH/legal_case_reports.zip"
fi

# Download the ZIP file
echo "Downloading file to $FULL_PATH..."
curl -L -o "$SAVE_PATH/legal_case_reports.zip" "$URL"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Download completed successfully."
else
    echo "Download failed."
    exit 1
fi