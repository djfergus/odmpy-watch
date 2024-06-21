#!/bin/bash

# Define source and destination directories
source_dir="/mnt/unraid/share_media/torrents/unsorted/odm-watch"
dest_dir="/mnt/unraid/share_media/torrents/unsorted/odm-watch/old"
error_dir="/mnt/unraid/share_media/torrents/unsorted/odm-watch/error"
audio_dir="/mnt/unraid/share_media/media/audiobooks/"

# Command to process each file
process_command="/usr/local/bin/odmpy dl --chapters --merge --mergeformat mp3 --keepcover -d $audio_dir "

# Function to process files
process_files() {
    local files=("$source_dir"/*.odm)  # List all files in source directory
    local file_count=${#files[@]}  # Count of files

    if [ $file_count -eq 0 ]; then
        echo "No files to process."
        return
    fi

    for file in "${files[@]}"; do
        if [ -f "$file" ]; then
            echo "Processing file: $file"

            # Run the processing command
            if $process_command "$file"; then
                echo "File processed successfully."
                # Move file to destination directory
                #echo "mv $file $dest_dir"
                mv "$file" "$dest_dir"
                echo "File moved to $dest_dir"
            else
                echo "Error: Failed to process $file"
                # You can choose to handle failure differently, like moving to an error directory
                mv "$file" "$error_dir"
            fi
        fi
    done
}

# Main loop to monitor the directory and process files
while true; do
    process_files
    sleep 60  # Wait for 60 seconds before checking again
done
