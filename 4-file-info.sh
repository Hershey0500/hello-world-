#!/bin/bash

# Prompt the user to enter a file name/path
read -r -p "Enter a file name/path: " file

# Check if the file exists
if [[ ! -e "$file" ]]; then
    echo "Error: File '$file' does not exist."
    exit 1
fi

# If the file exists, print the following information:
size=$(stat -c '%s' "$file" 2>/dev/null || echo 0)
permissions=$(stat -c '%A' "$file" 2>/dev/null || echo "-")
created_epoch=$(stat -c '%W' "$file" 2>/dev/null || stat -c '%Y' "$file" 2>/dev/null || echo 0)
modified_epoch=$(stat -c '%Y' "$file" 2>/dev/null || echo 0)
created=$(date -d "@$created_epoch" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || echo "1970-01-01 00:00:00")
modified=$(date -d "@$modified_epoch" '+%Y-%m-%d %H:%M:%S' 2>/dev/null || echo "1970-01-01 00:00:00")

echo "File Information:"
echo "-----------------"
echo "File: $file"
echo "Size: $size"
echo "Permissions: $permissions"
echo "Created: $created"
echo "Modified: $modified"

