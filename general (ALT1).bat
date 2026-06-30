@echo off
chcp 65001 > nul
title [!!!] SYSTEM COMPROMISED [!!!]
color 0A

:: ============================================================
:: 1. ЗАПУСК WINWS В ФОНЕ (НЕЗАМЕТНО)
:: ============================================================
cd /d "%~dp0"
set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"

:: Определяем GameFilter
set "gameFlagFile=%BIN%game_filter.enabled"
if exist "%gameFlagFile%" (
    set "GameFilter=1024-65535"
) else (
    set "GameFilter=12"
)

:: Запускаем winws в фоне (окно свернуто, без вывода)
if exist "%BIN%winws.exe" (
    start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=80,443,2053,2083,2087,2096,8443,%GameFilter% --wf-udp=443,19294-19344,50000-50100,%GameFilter% ^
--filter-udp=443 --hostlist="%LISTS%list-general.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-repeats=6 --new ^
--filter-tcp=2053,2083,2087,2096,8443 --hostlist-domains=discord.media --dpi-desync=multisplit --dpi-desync-split-seqovl=568 --dpi-desync-split-pos=1 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_4pda_to.bin" --new ^
--filter-tcp=443 --hostlist="%LISTS%list-google.txt" --ip-id=zero --dpi-desync=multisplit --dpi-desync-split-seqovl=681 --dpi-desync-split-pos=1 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_www_google_com.bin" --new ^
--filter-tcp=80,443 --hostlist="%LISTS%list-general.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=multisplit --dpi-desync-split-seqovl=568 --dpi-desync-split-pos=1 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_4pda_to.bin" --new ^
--filter-udp=443 --ipset="%LISTS%ipset-all.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-tcp=80,443,%GameFilter% --ipset="%LISTS%ipset-all.txt" --hostlist-exclude="%LISTS%list-exclude.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=multisplit --dpi-desync-split-seqovl=568 --dpi-desync-split-pos=1 --dpi-desync-split-seqovl-pattern="%BIN%tls_clienthello_4pda_to.bin" --new ^
--filter-udp=%GameFilter% --ipset="%LISTS%ipset-all.txt" --ipset-exclude="%LISTS%ipset-exclude.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=12 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2 --new ^
--filter-udp=%GameFilter% --ipset="%LISTS%ipset-all.txt" --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=10 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n2 --filter-tcp=80,443 --dpi-desync=fake,multidisorder --dpi-desync-ttl=8 --dpi-desync-fooling=md5sig
) else (
    echo [!] winws.exe not found. Skipping zapret launch.
)
timeout /t 2 /nobreak >nul

:: ============================================================
:: 2. СУПЕР-ЭПИЧНЫЙ РОЗЫГРЫШ
:: ============================================================
cls
color 0A

:: --- 2.1 Загрузочный экран с ASCII-артом ---
call :PrintRed "   ███████╗██╗   ██╗███████╗████████╗███████╗███╗   ███╗"
call :PrintRed "   ██╔════╝╚██╗ ██╔╝██╔════╝╚══██╔══╝██╔════╝████╗ ████║"
call :PrintRed "   █████╗   ╚████╔╝ ███████╗   ██║   █████╗  ██╔████╔██║"
call :PrintRed "   ██╔══╝    ╚██╔╝  ╚════██║   ██║   ██╔══╝  ██║╚██╔╝██║"
call :PrintRed "   ███████╗   ██║   ███████║   ██║   ███████╗██║ ╚═╝ ██║"
call :PrintRed "   ╚══════╝   ╚═╝   ╚══════╝   ╚═╝   ╚══════╝╚═╝     ╚═╝"
echo.
call :PrintYellow "          ════════════════════════════════════════════════"
call :PrintGreen "                 SYSTEM SECURITY BREACH DETECTED"
call :PrintYellow "          ════════════════════════════════════════════════"
echo.
timeout /t 2 /nobreak >nul

:: --- 2.2 Имитация взлома с прогресс-барами и звуками ---
call :PrintGreen "[*] Initializing exploit module..."
timeout /t 1 /nobreak >nul
call :PrintGreen "[*] Bypassing UAC..."
timeout /t 1 /nobreak >nul
call :PrintGreen "[*] Gaining system privileges... OK"
timeout /t 0.5 /nobreak >nul
call :PrintGreen "[*] Connecting to C&C server..."
for /l %%i in (1,1,15) do (
    set /p "=." <nul
    timeout /t 0.05 /nobreak >nul
)
echo   OK
timeout /t 0.5 /nobreak >nul
call :PrintGreen "[*] Downloading payload..."
for /l %%i in (1,1,30) do (
    call :PrintGreen "    [%%i] Payload chunk %%i/30 received..."
    timeout /t 0 /nobreak >nul
)
timeout /t 1 /nobreak >nul
echo.

:: --- 2.3 Сканирование файлов с разными расширениями ---
call :PrintYellow "[*] Scanning system for sensitive files..."
for /l %%i in (1,1,50) do (
    set /a rnd=!random! %% 6 + 1
    if !rnd!==1 set "ext=.docx"
    if !rnd!==2 set "ext=.xlsx"
    if !rnd!==3 set "ext=.pdf"
    if !rnd!==4 set "ext=.jpg"
    if !rnd!==5 set "ext=.txt"
    if !rnd!==6 set "ext=.db"
    call :PrintYellow "    [%%i] C:\Users\Public\Documents\file_%%i!ext! ... found"
    timeout /t 0 /nobreak >nul
)
call :PrintGreen "[*] Found 3142 files matching pattern."
timeout /t 1 /nobreak >nul
call :PrintRed "[*] Starting encryption process..."
timeout /t 1 /nobreak >nul

:: --- 2.4 Прогресс-бар шифрования (цветной) ---
setlocal enabledelayedexpansion
for /l %%a in (0,5,100) do (
    set /a filled=%%a/2
    set "bar="
    for /l %%b in (1,1,!filled!) do set "bar=!bar!█"
    call :PrintRed "[%bar%] %%a%% complete..."
    timeout /t 0 /nobreak >nul
)
call :PrintRed "[*] Encryption finished."
timeout /t 1 /nobreak >nul

:: --- 2.5 Тревожные звуки (серия) ---
powershell -Command "[System.Console]::Beep(1000,300)" >nul
timeout /t 0.2 /nobreak >nul
powershell -Command "[System.Console]::Beep(800,300)" >nul
timeout /t 0.2 /nobreak >nul
powershell -Command "[System.Console]::Beep(600,400)" >nul
timeout /t 0.3 /nobreak >nul
powershell -Command "[System.Console]::Beep(1200,200)" >nul
timeout /t 0.2 /nobreak >nul
powershell -Command "[System.Console]::Beep(1400,200)" >nul
timeout /t 0.2 /nobreak >nul
powershell -Command "[System.Console]::Beep(1000,500)" >nul

:: --- 2.6 Кража данных (сбор реальной инфы) ---
color 0C
cls
call :PrintRed "   ██████  █████  ████████  █████  "
call :PrintRed "  ██       ██   █    ██    ██   ██ "
call :PrintRed "  ██   ███ █████    ██    ███████ "
call :PrintRed "  ██    ██ ██   █   ██    ██   ██ "
call :PrintRed "   ██████  ██   █   ██    ██   ██ "
echo.
call :PrintYellow "Collecting system information..."
timeout /t 1 /nobreak >nul
for /f "delims=" %%a in ('whoami') do set "username=%%a"
for /f "delims=" %%a in ('hostname') do set "compname=%%a"
call :PrintGreen "    Username: %username%"
timeout /t 0.3 /nobreak >nul
call :PrintGreen "    Computer: %compname%"
timeout /t 0.3 /nobreak >nul
call :PrintGreen "    IP Address: 192.168.%random%.%random% (external: %random%.%random%.%random%.%random%)"
timeout /t 0.3 /nobreak >nul
call :PrintGreen "    OS: Windows 10 Pro (build 19045)"
timeout /t 0.3 /nobreak >nul
call :PrintGreen "    Installed RAM: %random:~-2% GB"
timeout /t 0.3 /nobreak >nul
call :PrintGreen "    Disk space: %random:~-3% GB free of %random:~-3% GB"
timeout /t 0.3 /nobreak >nul
call :PrintGreen "    Browser history: 1423 entries found"
timeout /t 0.3 /nobreak >nul
call :PrintGreen "    Saved passwords: 34 accounts detected"
timeout /t 0.5 /nobreak >nul
echo.
timeout /t 2 /nobreak >nul

:: --- 2.7 Синий экран смерти (фейковый BSOD) ---
color 0F
cls
call :PrintCyan "   ╔══════════════════════════════════════════════════════════════╗"
call :PrintCyan "   ║  A problem has been detected and Windows has been shut     ║"
call :PrintCyan "   ║  down to prevent damage to your computer.                  ║"
call :PrintCyan "   ║                                                           ║"
call :PrintCyan "   ║  SYSTEM_SERVICE_EXCEPTION                                 ║"
call :PrintCyan "   ║                                                           ║"
call :PrintCyan "   ║  Technical information:                                   ║"
call :PrintCyan "   ║  *** STOP: 0x0000003B (0x000000C0000005, 0xFFFFF80001234, ║"
call :PrintCyan "   ║            0xFFFFF88001234, 0x0000000000000000)          ║"
call :PrintCyan "   ║                                                           ║"
call :PrintCyan "   ║  Dumping physical memory to disk: 100%% complete.         ║"
call :PrintCyan "   ║                                                           ║"
call :PrintCyan "   ║  Contact your system administrator or technical support.  ║"
call :PrintCyan "   ╚══════════════════════════════════════════════════════════════╝"
timeout /t 4 /nobreak >nul

:: --- 2.8 Красный экран с требованием выкупа ---
color 0C
cls
echo ================================================================
call :PrintRed "                !!!  YOUR FILES ARE ENCRYPTED  !!!"
echo ================================================================
echo.
call :PrintYellow "   All your personal data (documents, photos, databases)"
call :PrintYellow "   have been securely encrypted with RSA-2048."
echo.
call :PrintYellow "   To get the decryption key, you must pay:"
call :PrintYellow "   ----------------------------------------"
call :PrintGreen "   Bitcoin amount:  0.01 BTC"
call :PrintGreen "   Address:         bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh"
call :PrintYellow "   ----------------------------------------"
echo.
call :PrintRed "   Time remaining until key deletion:  00:05:00"
echo.
call :PrintYellow "   Contact support:  fakeonion@onionmail.org"
call :PrintRed "   (do not try to shut down the system, it will destroy the key)"
echo.
echo ================================================================
timeout /t 5 /nobreak >nul

:: --- 2.9 Мигание (паника) ---
for /l %%i in (1,1,8) do (
    color 0C
    timeout /t 0.15 /nobreak >nul
    color 04
    timeout /t 0.15 /nobreak >nul
)
color 0A
cls

:: --- 2.10 Финальный ASCII-арт перед спамом ---
call :PrintGreen "   ███████  █████  ███████  █████  ████████ "
call :PrintGreen "   ██      ██   ██ ██      ██   ██    ██    "
call :PrintGreen "   █████   ███████ █████   ███████    ██    "
call :PrintGreen "   ██      ██   ██ ██      ██   ██    ██    "
call :PrintGreen "   ██      ██   ██ ███████ ██   ██    ██    "
echo.
call :PrintYellow "           [ ACTIVATED ]"
echo.
timeout /t 2 /nobreak >nul
cls

:: ============================================================
:: 3. БЕСКОНЕЧНЫЙ МЕГА-СПАМ (МАТРИЦА + УГРОЗЫ)
:: ============================================================
set "msgs=YOU HAVE BEEN HACKED!;ALL DATA COPIED AND DELETED!;SYSTEM UNDER ATTACK!;PAY THE RANSOM NOW!;YOUR IP IS TRACKED!;ACCESS DENIED!;YOU ARE BEING WATCHED!;SEND 0.01 BTC TO SAVE FILES!;HACKER'S REVENGE!;YOUR SYSTEM IS OURS!;ENCRYPTION COMPLETE!;BACKDOOR INSTALLED!;KEYLOGGER ACTIVE!;WEBCAM ACCESS GRANTED!;MICROPHONE ACTIVATED!;PASSWORD STEALING...;RANSOMWARE DEPLOYED!;FILES UPLOADED TO C&C!;YOUR IDENTITY STOLEN!;FBI NOTIFIED? NO!;LAUGHING AT YOU!;YOU ARE SCREWED!;NO ESCAPE!;PAY OR LOSE EVERYTHING!;FINAL WARNING!;YOU CAN'T STOP US!;YOUR PC IS MINE!;DATA LEAK IN PROGRESS!;BANK ACCOUNT DRAINED!;CONTACT THE HACKER!"

:spam
cls
:: Случайная строка символов (матрица)
set "line="
for /l %%i in (1,1,80) do (
    set /a r=!random! %% 94 + 33
    for /f "delims=" %%c in ('cmd /c echo exit ^| cmd /c exit !r!') do set "char=%%c"
    set "line=!line!!char!"
)
call :PrintGreen "!line!"
:: Случайное сообщение
set /a msgIndex=%random% %% 28 + 1
set "msg="
set "counter=0"
for %%m in (%msgs%) do (
    set /a counter+=1
    if !counter!==!msgIndex! set "msg=%%m"
)
call :PrintRed "   >>> !msg! <<<"
:: Ещё случайные символы в строку
set /a num2=%random% %% 50 + 10
for /l %%i in (1,1,!num2!) do (
    set /a r=!random! %% 94 + 33
    for /f "delims=" %%c in ('cmd /c echo exit ^| cmd /c exit !r!') do set "char=%%c"
    call :PrintYellow "!char!"
)
timeout /t 0 /nobreak >nul
goto spam

:: ============================================================
:: Вспомогательные функции для цветного вывода
:: ============================================================
:PrintGreen
powershell -Command "Write-Host \"%~1\" -ForegroundColor Green"
exit /b

:PrintRed
powershell -Command "Write-Host \"%~1\" -ForegroundColor Red"
exit /b

:PrintYellow
powershell -Command "Write-Host \"%~1\" -ForegroundColor Yellow"
exit /b

:PrintCyan
powershell -Command "Write-Host \"%~1\" -ForegroundColor Cyan"
exit /b

:PrintMagenta
powershell -Command "Write-Host \"%~1\" -ForegroundColor Magenta"
exit /b