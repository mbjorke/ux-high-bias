# ImageMagick Batch Rotation & Collage Cheat Sheet

This guide helps you batch-rotate images and create collages from the command line using ImageMagick’s `mogrify` and `montage`.

---

## 1. Install ImageMagick (if needed)

```bash
brew install imagemagick
```

## 2. Prepare Your Workspace (i.e. create your goofy directory, and then navigate into it)

```bash
mkdir -p public/goofy
cd public/goofy
```

## 3. Backup Originals (Recommended)
```bash
mkdir originals
cp *.jpg originals/
```

## 4. Batch Rotate Images (compass degrees)
Rotate all JPGs 90° clockwise:

```bash
mogrify -rotate 90 *.jpg
```

## 5. Resize Images for Collage
Resize all images to 400x400px (may distort):

```bash
mogrify -resize 400x400! *.jpg
```

## 6. Create a Collage
Arrange all JPGs in a 5-column grid with 4px spacing:

```bash
montage $(ls -v *.jpg) -tile 5x -geometry +4+4 collage.jpg

## 7. Common Issues & Tips

- File Overwrite: mogrify overwrites originals. Always backup first!
- File Order: Use ls -v *.jpg for natural sort order.
- Image Sizes: Pre-resize for a neat grid.
- Too Many Files: Adjust -tile as needed.
- Permissions: Run from a directory where you have write access.

## 8. Restore Originals (if needed)
bash
CopyInsert in Terminal
cp originals/*.jpg .

## 9. Resources
ImageMagick Documentation
montage options
mogrify options