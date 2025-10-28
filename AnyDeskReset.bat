@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
cls

echo ==========================================
echo         AnyDesk Reset Utility
echo ==========================================
echo By Br4hx
echo.

NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    echo ERROR: This script requires administrator privileges.
    echo Please right-click and choose "Run as administrator".
    pause
    goto :eof
)

if not exist "%ProgramFiles%\AnyDesk\AnyDesk.exe" if not exist "%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe" (
    echo WARNING: AnyDesk executable not found in standard paths.
    echo Continuing anyway...
)

echo Closing AnyDesk if running...
taskkill /F /IM AnyDesk.exe >nul 2>&1 && (
    echo AnyDesk closed successfully.
) || (
    echo AnyDesk was not running.
)

tasklist | find /i "AnyDesk.exe" >nul
if %errorlevel% EQU 0 (
    echo ERROR: AnyDesk is still running. Please close it manually.
    pause
    goto :eof
)

set "sourceRoaming=%USERPROFILE%\AppData\Roaming\AnyDesk"
set "sourceProgramData=C:\ProgramData\AnyDesk"

set "timestamp=%date:~6,4%-%date:~3,2%-%date:~0,2%_%time:~0,2%-%time:~3,2%"
set "timestamp=%timestamp: =0%"
set "destinationRoaming=%sourceRoaming%\backup_%timestamp%"
set "destinationProgramData=%sourceProgramData%\backup_%timestamp%"

if not exist "%destinationRoaming%" mkdir "%destinationRoaming%"
if not exist "%destinationProgramData%" mkdir "%destinationProgramData%"

set /a movedFiles=0
set "logFile=%TEMP%\AnyDeskReset_%timestamp%.log"
echo [%date% %time%] AnyDesk reset started. > "%logFile%"

call :moveFile "%sourceRoaming%\service.conf" "%destinationRoaming%"
call :moveFile "%sourceRoaming%\system.conf" "%destinationRoaming%"
call :moveFile "%sourceProgramData%\service.conf" "%destinationProgramData%"
call :moveFile "%sourceProgramData%\system.conf" "%destinationProgramData%"

echo.
if !movedFiles! EQU 0 (
    echo No files were moved.
) else if !movedFiles! EQU 1 (
    echo 1 file was moved.
) else (
    echo !movedFiles! files were moved.
)

echo.
echo ==========================================
echo AnyDesk reset completed successfully.
echo ------------------------------------------
echo Backups stored in:
echo   %destinationRoaming%
echo   %destinationProgramData%
echo ------------------------------------------
echo Log file:
echo   %logFile%
echo ==========================================
echo.
echo Press any key to exit...
pause >nul
goto :eof

:moveFile
if exist "%~1" (
    move "%~1" "%~2" >nul
    echo File moved: %~1
    echo [OK] %~1 >> "%logFile%"
    set /a movedFiles+=1
) else (
    echo File not found: %~1
    echo [MISSING] %~1 >> "%logFile%"
)
goto :eof
