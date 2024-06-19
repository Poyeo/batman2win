@echo off
setlocal

:: Check if FFmpeg is installed and accessible
ffmpeg -version >nul 2>&1
if errorlevel 1 (
    echo FFmpeg is not installed or not in your PATH.
    pause
    exit /b
)

:: Function to convert videos to H.265
:convert_video
set "input_file=%~1"
set "output_file=%~dpn1_converted.mp4"

echo Converting "%input_file%" to H.265...

ffmpeg -i "%input_file%" -c:v libx265 -c:a copy "%output_file%"

if errorlevel 1 (
    echo Error converting "%input_file%".
) else (
    echo Successfully converted "%input_file%" to "%output_file%".
)
goto :eof

:: Main script
if "%~1"=="" (
    echo No files or folders provided.
    echo Drag and drop files or folders onto this script to convert videos to H.265.
    pause
    exit /b
)

:process
echo Processing %1
if exist "%~f1" (
    if exist "%~f1\*" (
        :: It's a directory
        echo "%~f1" is a directory.
        for /r "%~f1" %%V in (*.mp4 *.mkv *.avi *.mov *.flv *.wmv) do call :convert_video "%%V"
    ) else (
        :: It's a file
        echo "%~f1" is a file.
        call :convert_video "%~f1"
    )
) else (
    echo "%~f1" does not exist.
)

shift
if "%~1"=="" goto :done
goto :process

:done
echo All conversions are complete.
pause
endlocal
exit /b
