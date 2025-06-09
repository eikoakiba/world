#!/bin/bash

# Ask for new status from the user
read -p "Enter new status: " new_status
read -p "Enter new music: " new_song

# If you give link, it will be actually link :)
if [[ $new_song == *"http"* ]]; then
  new_song="<a href='$new_song'>$new_song</a>"
fi

# Extract the current "Now:" value from index.html
cp index.html index.html.back
current_status=$(grep -oP '(?<=Now: ).*?(?= <br>)' index.html)
current_song=$(grep -oP '(?<=Song: ).*' index.html)

# Check if we found a current status
if [ -z "$current_status" ]; then
  echo "Could not find current status. Make sure 'Now: ... <br>' exists."
  exit 1
fi

if [ -z "$current_song" ]; then
  echo "Could not find current song. Make sure 'Song: ... <br>' exists."
  exit 1
fi

# Replace the old status with the new one
if [[ ! -z $new_status ]]; then
  sed -i "s|Now: $current_status <br>|Now: $new_status <br>|" index.html
  echo "Updated status from '$current_status' to '$new_status'"
fi

if [[ ! -z $new_song ]]; then
  sed -i "s|Song: $current_song|Song: $new_song|" index.html
  echo "Updated song from '$current_song' to '$new_song'"
fi
