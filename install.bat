@echo off
:: Big Clock Lock Screen — one-click installer.
:: Downloads server.py from GitHub, installs to auto-startup.
:: Just double-click this file — everything is automatic.

set "INSTALL_DIR=%APPDATA%\BigClock"
set "SCRIPT=%INSTALL_DIR%\server.py"
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "VBS=%STARTUP%\BigClockServer.vbs"
set "DOWNLOAD_URL=https://raw.githubusercontent.com/bsb3166/big-clock/main/server.py"

echo.
echo  Big Clock Lock Screen Installer
echo  ================================
echo.

:: Find pythonw.exe
for /f "delims=" %%i in ('where pythonw 2^>nul') do set "PYTHONW=%%i"
if "%PYTHONW%"=="" (
    echo  [ERROR] Python not found. Please install Python and add to PATH.
    echo          https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)

:: Create install directory
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

:: Download server.py from GitHub
echo  Downloading server.py ...
powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%SCRIPT%'" 2>nul
if not exist "%SCRIPT%" (
    echo  [ERROR] Download failed. Check your internet connection.
    pause
    exit /b 1
)
echo  [OK] Downloaded to %SCRIPT%

:: Create VBS launcher in Startup folder
(
echo Set WshShell = CreateObject^("WScript.Shell"^)
echo WshShell.Run """%PYTHONW%"" ""%SCRIPT%"" --daemon", 0, False
) > "%VBS%"
echo  [OK] Added to Windows startup.

:: Start daemon now
start "" "%PYTHONW%" "%SCRIPT%" --daemon
echo  [OK] Lock screen service started (port 8888).

echo.
echo  Done! The lock screen API runs silently on every login.
echo  You can close this window.
echo.
pause
