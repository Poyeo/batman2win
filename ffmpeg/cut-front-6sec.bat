@echo off
setlocal

rem Check if a file was dragged and dropped
if "%~1"=="" (
    echo Please drag and drop a video file onto this script.
    pause
    exit /b
)

rem Get the input file path
set "input_file=%~1"
rem Generate the output file path by adding "_trimmed" before the file extension
set "output_file=%~dpn1_trimmed%~x1"

rem Use ffmpeg to cut the first 5 seconds
ffmpeg -y -i "%input_file%" -ss 00:00:06 -c copy "%output_file%"

rem Notify the user of completion
echo The first 5 seconds have been removed from the video.
echo The new file is saved as: "%output_file%"
pause
endlocal
