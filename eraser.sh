#!/bin/bash
# LaTeX Cache Cleaner with Backup for Linux/Ubuntu
# Creates .txt backup of all .tex files in the same folder
# Make executable: chmod +x clean_latex.sh

echo "======================================"
echo " LaTeX Cache Cleaner with Backup"
echo "======================================"
echo ""

# Get the directory where the script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

echo "Working in: $DIR"
echo ""

# Backup all .tex files as .txt in the same location
echo "Creating .txt backups of all .tex files..."
echo ""

backup_count=0

# Find all .tex files and create .txt backups
for tex_file in $(find . -name "*.tex" -type f); do
    # Get the directory and filename without extension
    dir=$(dirname "$tex_file")
    filename=$(basename "$tex_file" .tex)
    
    # Create backup as .txt in the same directory
    backup_file="${dir}/${filename}_backup.txt"
    
    cp "$tex_file" "$backup_file"
    
    if [ $? -eq 0 ]; then
        echo "  Created: ${backup_file#./}"
        ((backup_count++))
    fi
done

echo ""
echo "Backed up $backup_count .tex files as .txt"
echo ""
echo "---------------------------------------"
echo "Cleaning LaTeX cache files..."
echo ""

# Delete all LaTeX auxiliary files (but NOT .tex or .txt files!)
find . -type f \( \
    -name "*.aux" -o -name "*.log" -o -name "*.out" -o \
    -name "*.toc" -o -name "*.lof" -o -name "*.lot" -o \
    -name "*.idx" -o -name "*.bbl" -o -name "*.blg" -o \
    -name "*.brf" -o -name "*.ind" -o -name "*.ilg" -o \
    -name "*.glo" -o -name "*.gls" -o -name "*.glg" -o \
    -name "*.ist" -o -name "*.acn" -o -name "*.acr" -o \
    -name "*.alg" -o -name "*.synctex" -o -name "*.synctex.gz" -o \
    -name "*.nav" -o -name "*.snm" -o -name "*.vrb" -o \
    -name "*.fls" -o -name "*.fdb_latexmk" -o -name "*.dvi" -o \
    -name "*.xdv" -o -name "*.bcf" -o -name "*.run.xml" -o \
    -name "*-blx.bib" -o -name "*.cb" -o -name "*.cb2" -o \
    -name "*.spl" -o -name "*.listing" -o -name "*.figlist" -o \
    -name "*.makefile" -o -name "*.fmt" -o -name "*.glsdefs" -o \
    -name "*.loa" -o -name "*.dpth" -o -name "*.md5" -o \
    -name "*.auxlock" \
    \) -delete 2>/dev/null

# Remove cache directories
find . -type d -name "_minted-*" -exec rm -rf {} + 2>/dev/null
find . -type d -name "auto" -exec rm -rf {} + 2>/dev/null
find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null

echo "======================================"
echo "        CLEANING COMPLETE!"
echo "======================================"
echo ""
echo " ✓ All .tex files backed up as _backup.txt"
echo " ✓ Cache files cleaned"
echo ""
echo " To restore: rename .txt back to .tex"
echo " Example: mv main_backup.txt main.tex"
echo ""
echo " Your backup files:"
find . -name "*_backup.txt" -type f | head -10
echo ""
echo "======================================"
echo ""

# If running in terminal, wait for keypress
if [ -t 0 ]; then
    read -p "Press Enter to close..."
fi
