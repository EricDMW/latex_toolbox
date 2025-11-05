@echo off
:: LaTeX Cache Cleaner with Backup for Windows
:: Creates .txt backup of all .tex files in the same folder

echo ======================================
echo  LaTeX Cache Cleaner with Backup
echo ======================================
echo.

:: Create backup of all .tex files as .txt in the same location
echo Backing up .tex files as .txt...
echo.

set /a backup_count=0
for /r %%f in (*.tex) do (
    copy "%%f" "%%~dpnf_backup.txt" >nul 2>&1
    if !errorlevel! equ 0 (
        echo Created backup: %%~nf_backup.txt
        set /a backup_count+=1
    )
)

echo.
echo Backed up %backup_count% .tex files
echo.
echo ---------------------------------------
echo Cleaning LaTeX cache files...
echo.

:: Delete all LaTeX auxiliary files (but NOT .tex or .txt files!)
del /s /q *.aux *.log *.out *.toc *.lof *.lot *.idx *.bbl *.blg *.brf 2>nul
del /s /q *.ind *.ilg *.glo *.gls *.glg *.ist *.acn *.acr *.alg 2>nul
del /s /q *.synctex *.synctex.gz *.nav *.snm *.vrb *.xdv 2>nul
del /s /q *.fls *.fdb_latexmk *.dvi *.bcf *.run.xml *-blx.bib 2>nul
del /s /q *.cb *.cb2 *.spl *.listing *.figlist *.makefile *.fmt 2>nul
del /s /q *.glsdefs *.loa *.dpth *.md5 *.auxlock 2>nul

:: Remove cache directories
for /d /r %%d in (_minted-*) do rd /s /q "%%d" 2>nul
for /d /r %%d in (auto) do rd /s /q "%%d" 2>nul
for /d /r %%d in (__pycache__) do rd /s /q "%%d" 2>nul

echo.
echo ======================================
echo         CLEANING COMPLETE!
echo ======================================
echo.
echo  .tex files backed up as _backup.txt
echo  To restore: rename .txt back to .tex
echo.
echo  Example files created:
echo   main_backup.txt (from main.tex)
echo   chapter1_backup.txt (from chapter1.tex)
echo   chapter2_backup.txt (from chapter2.tex)
echo.
echo ======================================
echo.
pause
