@echo off
chcp 65001 >nul
title AnyDesk Reset - Br4hx
net session >nul 2>&1 || (powershell -nop -c "Start-Process '%~f0' -Verb RunAs" & exit /b)
echo.
echo   /\_/\
echo  ( o.o )   AnyDesk Reset
echo   ^> ^^ ^<    by Br4hx
echo  ==============================
echo.

set "AD=%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe"
if not exist "%AD%" set "AD=%ProgramFiles%\AnyDesk\AnyDesk.exe"
if not exist "%AD%" (echo [X] AnyDesk no encontrado & pause & exit /b 1)

echo [#---] Matando AnyDesk...
net stop AnyDeskService >nul 2>&1
taskkill /f /im AnyDesk.exe >nul 2>&1

echo [##--] Guardando ID vieja en el baul...
for /f %%t in ('powershell -nop -c "Get-Date -f yyyyMMdd_HHmmss"') do set "B=%TEMP%\AnyDeskBackup_%%t"
md "%B%"
for %%f in (system.conf service.conf) do (
  move /y "%APPDATA%\AnyDesk\%%f" "%B%\roaming_%%f" >nul 2>&1
  move /y "%ProgramData%\AnyDesk\%%f" "%B%\pd_%%f" >nul 2>&1
)
del /q "%APPDATA%\AnyDesk\*.trace" "%ProgramData%\AnyDesk\*.trace" >nul 2>&1

echo [###-] Resucitando AnyDesk...
net start AnyDeskService >nul 2>&1
start "" "%AD%"

echo [####] Esperando ID nueva (max 20s)...
for /l %%i in (1,1,20) do if not exist "%ProgramData%\AnyDesk\system.conf" (choice /c rx /t 1 /d x /n >nul & if not errorlevel 2 if not defined R (set R=1& call :rick))

echo.
echo  [OK] ID nueva generada. Mirala en AnyDesk.
echo  Backup: %B%
echo.
if defined R (echo  Rick no te dejara ir. Pulsa una tecla... & pause >nul) else (echo  Cerrando en 8s... & timeout /t 8 >nul)
exit /b

:rick
echo.
echo   \o/  RICKROLL'D  \o/
echo    ^|    ^<(o_o)^>    ^|
echo   / \             / \
start "" https://youtu.be/dQw4w9WgXcQ
exit /b
