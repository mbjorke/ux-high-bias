#!/bin/bash
# make-montage.sh
# Usage: ./make-montage.sh [folder] [columns]
# Example: ./make-montage.sh . 5

DIR="${1:-.}"
COLS="${2:-5}"

echo "WARNING: This script will modify images (rotate/resize) in '$DIR'."
read -p "Do you want to make a copy in a new folder before processing? (y/n): " COPY_CHOICE

if [[ "$COPY_CHOICE" =~ ^[Yy]$ ]]; then
  WORKDIR="${DIR}/montage-workdir"
  mkdir -p "$WORKDIR"
  cp "$DIR"/*.{jpg,jpeg,png,webp,gif,bmp,tiff} "$WORKDIR" 2>/dev/null
  echo "Images copied to $WORKDIR"
  DIR="$WORKDIR"
fi

shopt -s nullglob

echo "Auto-orienting images in: $DIR"
mogrify -auto-orient "$DIR"/*.{jpg,jpeg,png,webp,gif,bmp,tiff}

echo "Resizing all images to 400x400 for montage..."
mogrify -resize 400x400\! "$DIR"/*.{jpg,jpeg,png,webp,gif,bmp,tiff}

echo "Creating montage from all images in $DIR..."
montage "$DIR"/*.{jpg,jpeg,png,webp,gif,bmp,tiff} -tile "${COLS}x" -geometry +4+4 "$DIR/montage.jpg"

echo "Montage created at $DIR/montage.jpg"