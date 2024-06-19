@echo off
setlocal enabledelayedexpansion

REM Check if FFmpeg is installed
where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
    echo FFmpeg is not installed or not in the system PATH. Please install FFmpeg and try again.
    pause
    exit /b 1
)

REM Check if a file is provided
if "%~1" == "" (
    echo Please drag and drop an OGV file onto this script.
    pause
    exit /b 1
)

REM Input and output file paths with quotes
set "inputFile=%~1"
set "outputFile=%~dpn1_480p.mp4"

REM Run FFmpeg command with quotes around file paths
ffmpeg -i "!inputFile!"  -vf scale=854:480 "!outputFile!"

REM Check FFmpeg exit code
if !errorlevel! neq 0 (
    echo An error occurred during conversion.
    pause
    exit /b 1
)

echo Conversion successful. Output file: "!outputFile!"
pause