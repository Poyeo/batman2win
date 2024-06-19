@echo off
setlocal enabledelayedexpansion

for %%f in (%*) do (
    set "file=%%~ff"
    set "filepath=%%~dpnxf"
    
    rem Get the creation date
    for /f "usebackq tokens=*" %%a in (`powershell -command "(Get-Item '%%f').CreationTime.ToString('yyyyMMdd_HHmmss')"`) do (
        set "date=%%a"
    )

    rem Calculate MD5 hash and get the first 6 characters
    for /f "usebackq tokens=* delims=" %%h in (`certutil -hashfile "%%f" MD5 ^| findstr /v /c:"CertUtil" /c:"hash"`) do (
        set "hash=%%h"
        set "hash=!hash:~0,6!"
    )
    
    rem Rename the file
    set "newname=!date!_!hash!%%~xf"
    echo Renaming "%%~ff" to "!newname!"
    ren "%%~ff" "!newname!"
)

endlocal
exit
