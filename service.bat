@echo off
chcp 65001 > nul
title ZAPRET SERVICE - VIRUS SELECTOR
color 0A

:: Запрос прав администратора
if "%1"=="admin" (
    echo Started with admin rights
) else (
    echo Requesting admin rights...
    powershell -Command "Start-Process 'cmd.exe' -ArgumentList '/c \"\"%~f0\" admin\"' -Verb RunAs"
    exit
)

set "LOCAL_VERSION=1.9.0b"

:: ========== ОБРАБОТЧИКИ ВЫЗОВОВ ==========
if "%~1"=="status_zapret" (
    call :test_service zapret soft
    call :tcp_enable
    exit /b
)

if "%~1"=="check_updates" (
    if not "%~2"=="soft" (
        start /b service check_updates soft
    ) else (
        call :service_check_updates soft
    )
    exit /b
)

if "%~1"=="load_game_filter" (
    call :game_switch_status
    exit /b
)
:: =========================================

:: ========== МЕНЮ НА 4 ПУНКТА ==========
:menu
setlocal EnableDelayedExpansion
cls
call :ipset_switch_status
call :game_switch_status

echo =========  v%LOCAL_VERSION%  =========
echo   Select virus to deploy:
echo   1. General (ALT)   - Telegram - Telegram web
echo   2. General (ALT1)  - Telegram - YouTube
echo   3. General (ALT2)  - Telegram
echo   4. General (ALT3)  - Telegram - Telegram web - YouTube
echo   0. Exit
echo.
set /p menu_choice=Enter choice (0-4): 

if "%menu_choice%"=="1" goto run_alt
if "%menu_choice%"=="2" goto run_alt1
if "%menu_choice%"=="3" goto run_alt2
if "%menu_choice%"=="4" goto run_alt3
if "%menu_choice%"=="0" exit /b
goto menu

:run_alt
call :launch "general (ALT).bat"
goto menu

:run_alt1
call :launch "general (ALT1).bat"
goto menu

:run_alt2
call :launch "general (ALT2).bat"
goto menu

:run_alt3
call :launch "general (ALT3).bat"
goto menu

:launch
if not exist "%~1" (
    call :PrintRed "ERROR: %~1 not found in current folder!"
    pause
    exit /b
)
call :PrintGreen "Deploying %~1 ..."
timeout /t 1 /nobreak >nul
call "%~1"
exit /b

:: ============ ВСЕ ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ==============
:tcp_enable
netsh interface tcp show global | findstr /i "timestamps" | findstr /i "enabled" > nul || netsh interface tcp set global timestamps=enabled > nul 2>&1
exit /b

:test_service
set "ServiceName=%~1"
set "ServiceStatus="
for /f "tokens=3 delims=: " %%A in ('sc query "%ServiceName%" ^| findstr /i "STATE"') do set "ServiceStatus=%%A"
set "ServiceStatus=%ServiceStatus: =%"
if "%ServiceStatus%"=="RUNNING" (
    if "%~2"=="soft" (
        echo "%ServiceName%" is ALREADY RUNNING as service, use "service.bat" and choose "Remove Services" first if you want to run standalone bat.
        pause
        exit /b
    ) else (
        echo "%ServiceName%" service is RUNNING.
    )
) else if "%ServiceStatus%"=="STOP_PENDING" (
    call :PrintYellow "!ServiceName! is STOP_PENDING, that may be caused by a conflict with another bypass. Run Diagnostics to try to fix conflicts"
) else if not "%~2"=="soft" (
    echo "%ServiceName%" service is NOT running.
)
exit /b

:game_switch_status
chcp 437 > nul
set "gameFlagFile=%~dp0bin\game_filter.enabled"
if exist "%gameFlagFile%" (
    set "GameFilterStatus=enabled"
    set "GameFilter=1024-65535"
) else (
    set "GameFilterStatus=disabled"
    set "GameFilter=12"
)
exit /b

:ipset_switch_status
chcp 437 > nul
set "listFile=%~dp0lists\ipset-all.txt"
for /f %%i in ('type "%listFile%" 2^>nul ^| find /c /v ""') do set "lineCount=%%i"
if !lineCount!==0 (
    set "IPsetStatus=any"
) else (
    findstr /R "^203\.0\.113\.113/32$" "%listFile%" >nul
    if !errorlevel!==0 (
        set "IPsetStatus=none"
    ) else (
        set "IPsetStatus=loaded"
    )
)
exit /b

:service_check_updates
chcp 437 > nul
set "GITHUB_VERSION_URL=https://raw.githubusercontent.com/Flowseal/zapret-discord-youtube/main/.service/version.txt"
set "GITHUB_RELEASE_URL=https://github.com/Flowseal/zapret-discord-youtube/releases/tag/"
set "GITHUB_DOWNLOAD_URL=https://github.com/Flowseal/zapret-discord-youtube/releases/latest/download/zapret-discord-youtube-"

for /f "delims=" %%A in ('powershell -command "(Invoke-WebRequest -Uri \"%GITHUB_VERSION_URL%\" -Headers @{\"Cache-Control\"=\"no-cache\"} -TimeoutSec 5).Content.Trim()" 2^>nul') do set "GITHUB_VERSION=%%A"
if not defined GITHUB_VERSION (
    echo Warning: failed to fetch the latest version. This warning does not affect the operation of zapret
    if "%1"=="soft" exit 
    goto menu
)
if "%LOCAL_VERSION%"=="%GITHUB_VERSION%" (
    echo Latest version installed: %LOCAL_VERSION%
    if "%1"=="soft" exit 
    pause
    goto menu
) 
echo New version available: %GITHUB_VERSION%
echo Release page: %GITHUB_RELEASE_URL%%GITHUB_VERSION%
set "CHOICE="
set /p "CHOICE=Do you want to automatically download the new version? (Y/N) (default: Y) "
if "%CHOICE%"=="" set "CHOICE=Y"
if /i "%CHOICE%"=="y" set "CHOICE=Y"
if /i "%CHOICE%"=="Y" (
    echo Opening the download page...
    start "" "%GITHUB_DOWNLOAD_URL%%GITHUB_VERSION%.rar"
)
if "%1"=="soft" exit 
pause
goto menu

:PrintGreen
powershell -Command "Write-Host \"%~1\" -ForegroundColor Green"
exit /b

:PrintRed
powershell -Command "Write-Host \"%~1\" -ForegroundColor Red"
exit /b

:PrintYellow
powershell -Command "Write-Host \"%~1\" -ForegroundColor Yellow"
exit /b