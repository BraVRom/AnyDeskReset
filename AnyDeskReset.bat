@echo off
chcp 65001 >nul
cls

:: Introduction
echo By BraVRom - Br4hx
echo This script helps reset AnyDesk by moving its configuration files to a backup folder.
echo It also ensures that AnyDesk is closed before proceeding.
echo.

:: Check for administrator privileges
NET SESSION >nul 2>&1
if %errorLevel% NEQ 0 (
    echo ERROR: This script requires administrator privileges.
    echo Close this window and run it as administrator.
    pause
    exit /b
)

:: Close AnyDesk if it's running
echo Closing AnyDesk...
taskkill /F /IM AnyDesk.exe >nul 2>&1 && echo AnyDesk closed successfully. || echo AnyDesk was not running.

:: Check if AnyDesk is still open
tasklist | find /i "AnyDesk.exe" >nul
if %errorLevel% EQU 0 (
    echo ERROR: AnyDesk is still running. Please close AnyDesk manually and try again.
    pause
    exit /b
)

:: Define source and destination folders
set "sourceRoaming=%USERPROFILE%\AppData\Roaming\AnyDesk"
set "destinationRoaming=%sourceRoaming%\old"

set "sourceProgramData=C:\ProgramData\AnyDesk"
set "destinationProgramData=%sourceProgramData%\old"

:: Create backup folders if they don't exist
if not exist "%destinationRoaming%" mkdir "%destinationRoaming%"
if not exist "%destinationProgramData%" mkdir "%destinationProgramData%"

:: Moved files counter
set /a movedFiles=0

:: Move files if they exist
call :moveFile "%sourceRoaming%\service.conf" "%destinationRoaming%"
call :moveFile "%sourceRoaming%\system.conf" "%destinationRoaming%"
call :moveFile "%sourceProgramData%\service.conf" "%destinationProgramData%"
call :moveFile "%sourceProgramData%\system.conf" "%destinationProgramData%"

:: Final message
echo.
if %movedFiles% EQU 0 (
    echo No files were moved.
) else if %movedFiles% EQU 1 (
    echo 1 file was moved.
) else (
    echo %movedFiles% files were moved.
)

echo.
echo AnyDesk reset completed successfully.
echo Enjoy your reset without the annoying countdown.
echo.

pause
exit

:: Function to move files if they exist
:moveFile
if exist "%~1" (
    move "%~1" "%~2" >nul
    echo File moved: %~1
    set /a movedFiles+=1
) else (
    echo File not found: %~1
)
exit /b
