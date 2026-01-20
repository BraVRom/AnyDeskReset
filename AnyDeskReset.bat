@echo off
setlocal enabledelayedexpansion
chcp 65001 >nul
title AnyDesk Reset Tool

echo ==========================================
echo           AnyDesk Reset Utility
echo ==========================================
echo By Br4hx (Jan 2026 Version)
echo.

:: --- ADMIN CHECK ---
NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    echo ERROR: Debes ejecutar como Administrador.
    pause
    goto :eof
)

:: --- STOP ANYDESK ---
echo [1/6] Deteniendo procesos de AnyDesk...
net stop AnyDeskService >nul 2>&1
taskkill /F /IM AnyDesk.exe >nul 2>&1
timeout /t 2 /nobreak >nul

:: --- PATHS ---
set "roaming=%APPDATA%\AnyDesk"
set "programData=C:\ProgramData\AnyDesk"
set "timestamp=%date:~6,4%-%date:~3,2%-%date:~0,2%_%time:~0,2%-%time:~3,2%"
set "timestamp=%timestamp: =0%"
set "backupRoot=%TEMP%\AnyDeskBackup_%timestamp%"
set "backupRoaming=%backupRoot%\Roaming"
set "backupProgramData=%backupRoot%\ProgramData"

mkdir "%backupRoaming%" >nul 2>&1
mkdir "%backupProgramData%" >nul 2>&1

:: --- BACKUP & CLEAN ---
echo [2/6] Eliminando ID antigua y creando backup...
set /a movedFiles=0

if exist "%roaming%\system.conf" (
    move /Y "%roaming%\system.conf" "%backupRoaming%\" >nul
    set /a movedFiles+=1
)
if exist "%programData%\system.conf" (
    move /Y "%programData%\system.conf" "%backupProgramData%\" >nul
    set /a movedFiles+=1
)

:: Limpiar rastros
del /f /q "%roaming%\*.trace" >nul 2>&1
del /f /q "%programData%\*.trace" >nul 2>&1

:: --- REGENERATE ---
echo [3/6] Iniciando AnyDesk para generar nueva ID...
set "AnyDeskPath="
if exist "%ProgramFiles%\AnyDesk\AnyDesk.exe" set "AnyDeskPath=%ProgramFiles%\AnyDesk\AnyDesk.exe"
if exist "%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe" set "AnyDeskPath=%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe"

if not defined AnyDeskPath (
    echo ERROR: No se encontró AnyDesk instalado.
    pause
    goto :eof
)

start "" "%AnyDeskPath%"

:: --- WAIT LOOP (FIXED) ---
echo [4/6] Esperando inicialización...
for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a"
set /a tries=0

:waitLoop
set /a tries+=1
set /a pct=tries*5

:: Mostrar progreso en la misma línea sin usar CLS
<nul set /p "=Progreso: [!pct!%%] Verificando archivos...!CR!"

:: Pequeña pausa para dar tiempo al sistema
timeout /t 1 >nul

:: Verificamos si AnyDesk ya creó el nuevo archivo de configuración
if exist "%programData%\system.conf" goto nextStep
if exist "%roaming%\system.conf" goto nextStep

if !tries! GEQ 20 (
    echo.
    echo [!] Tiempo de espera agotado. Continuando...
    goto nextStep
)
goto waitLoop

:nextStep
echo.
echo [5/6] ID Generada. Cerrando AnyDesk...
timeout /t 2 /nobreak >nul
taskkill /F /IM AnyDesk.exe >nul 2>&1

:: --- RESTORE USER DATA ---
echo [6/6] Restaurando configuraciones de usuario...
if exist "%backupRoaming%\user.conf" copy /Y "%backupRoaming%\user.conf" "%roaming%\" >nul

echo.
echo ==========================================
echo Proceso completado exitosamente.
echo Backup en: %backupRoot%
echo ==========================================
pause