#!/bin/bash
# mark-rotation-candidates.sh
# Usage: ./mark-rotation-candidates.sh [folder1] [folder2] ...
# Scans each folder (or current dir if none) for portrait images (height > width).

shopt -s nullglob

if [ "$#" -eq 0 ]; then
  set -- .
fi

for DIR in "$@"; do
  echo "Scanning folder: $DIR"
  needs_rotation=0
  for img in "$DIR"/*.{jpg,jpeg,png,webp,gif,bmp,tiff}; do
    [ -e "$img" ] || continue
    read w h < <(identify -format "%w %h" "$img" 2>/dev/null)
    if [ -z "$w" ] || [ -z "$h" ]; then
      echo "  Could not read $img (unsupported or corrupted file?)"
      continue
    fi
    if [ "$h" -gt "$w" ]; then
      echo "  $img needs rotation (portrait: ${w}x${h})"
      needs_rotation=1
    fi
  done
  if [ $needs_rotation -eq 0 ]; then
    echo "  All images are landscape or square. No rotation needed in $DIR."
  fi
done