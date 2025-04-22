#!/bin/bash
# find-portrait-images.sh
# Usage: ./find-portrait-images.sh [directory] [output_file]
# Lists all images in the directory tree that are portrait (height > width).
# If output_file is specified, saves the list there.

DIR="${1:-.}"
OUT="${2:-}"

find "$DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" -o -iname "*.bmp" -o -iname "*.tiff" \) | while IFS= read -r img; do
  read -r w h < <(identify -format "%w %h" "$img" 2>/dev/null)
  if [[ -n "$w" && -n "$h" && "$h" -gt "$w" ]]; then
    msg="$img needs rotation ($w x $h)"
    echo "$msg"
    [[ -n "$OUT" ]] && echo "$msg" >> "$OUT"
  fi
done