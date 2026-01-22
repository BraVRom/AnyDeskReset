@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title AnyDesk Reset Tool - Br4hx

echo ==========================================
echo           AnyDesk Reset Utility
echo ==========================================
echo By Br4hx (Updated Jan 2026)
echo.

:: --- ADMIN CHECK ---
NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    echo ERROR: Debes ejecutar como Administrador.
    pause
    goto :eof
)

:: --- STOP ANYDESK ---
echo [1/7] Deteniendo procesos de AnyDesk...
net stop AnyDeskService >nul 2>&1
taskkill /F /IM AnyDesk.exe >nul 2>&1
:: Segundo intento para asegurar
timeout /t 1 /nobreak >nul
taskkill /F /IM AnyDesk.exe >nul 2>&1

:: --- PATHS ---
set "roaming=%APPDATA%\AnyDesk"
set "programData=%ProgramData%\AnyDesk"
set "timestamp=%date:~6,4%-%date:~3,2%-%date:~0,2%_%time:~0,2%-%time:~3,2%"
set "timestamp=%timestamp: =0%"
set "backupRoot=%TEMP%\AnyDeskBackup_%timestamp%"
set "backupRoaming=%backupRoot%\Roaming"
set "backupProgramData=%backupRoot%\ProgramData"

mkdir "%backupRoaming%" >nul 2>&1
mkdir "%backupProgramData%" >nul 2>&1

:: --- BACKUP ESSENTIALS ---
echo [2/7] Creando respaldo de datos de usuario...

if exist "%roaming%\user.conf" (
    copy /Y "%roaming%\user.conf" "%backupRoaming%\" >nul
    echo    - user.conf respaldado.
)

if exist "%roaming%\thumbnails" (
    xcopy /E /I /Y "%roaming%\thumbnails" "%backupRoaming%\thumbnails" >nul
    echo    - thumbnails respaldados.
)

echo [3/7] Eliminando configuraciones de ID antiguas...

:: Mover system.conf y service.conf (Roaming)
if exist "%roaming%\system.conf" move /Y "%roaming%\system.conf" "%backupRoaming%\" >nul
if exist "%roaming%\service.conf" move /Y "%roaming%\service.conf" "%backupRoaming%\" >nul

:: Mover system.conf y service.conf (ProgramData)
if exist "%programData%\system.conf" move /Y "%programData%\system.conf" "%backupProgramData%\" >nul
if exist "%programData%\service.conf" move /Y "%programData%\service.conf" "%backupProgramData%\" >nul

del /f /q "%roaming%\*.trace" >nul 2>&1
del /f /q "%programData%\*.trace" >nul 2>&1

echo [4/7] Iniciando AnyDesk para generar nueva ID...
set "AnyDeskPath="
if exist "%ProgramFiles%\AnyDesk\AnyDesk.exe" set "AnyDeskPath=%ProgramFiles%\AnyDesk\AnyDesk.exe"
if exist "%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe" set "AnyDeskPath=%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe"

if not defined AnyDeskPath (
    echo ERROR: No se encontró AnyDesk instalado.
    pause
    goto :eof
)

start "" "%AnyDeskPath%"

:: --- WAIT LOOP ---
echo [5/7] Esperando generacion de nuevos archivos...
for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a"
set /a tries=0

:waitLoop
set /a tries+=1
set /a pct=tries*5
<nul set /p "=Progreso: [!pct!%%] Verificando archivos...!CR!"
timeout /t 1 >nul

:: Verificamos system.conf O service.conf (cualquiera sirve)
if exist "%programData%\system.conf" goto nextStep
if exist "%programData%\service.conf" goto nextStep
if exist "%roaming%\system.conf" goto nextStep
if exist "%roaming%\service.conf" goto nextStep

if !tries! GEQ 20 (
    echo.
    echo [!] Tiempo de espera agotado. Continuando de todas formas...
    goto nextStep
)
goto waitLoop

:nextStep
echo.
echo [6/7] ID Generada. Cerrando AnyDesk para restaurar datos...
timeout /t 2 /nobreak >nul
taskkill /F /IM AnyDesk.exe >nul 2>&1
net stop AnyDeskService >nul 2>&1

:: --- RESTORE USER DATA ---
echo [7/7] Restaurando favoritos y miniaturas...

if exist "%backupRoaming%\user.conf" (
    copy /Y "%backupRoaming%\user.conf" "%roaming%\" >nul
    echo    - Favoritos restaurados.
)

if exist "%backupRoaming%\thumbnails" (
    xcopy /E /I /Y "%backupRoaming%\thumbnails" "%roaming%\thumbnails" >nul
    echo    - Miniaturas restauradas.
)

echo.
echo ==========================================
echo Proceso completado exitosamente.
echo Backup guardado en: %backupRoot%
echo ==========================================
pause
