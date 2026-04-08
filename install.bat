@echo off
:: Big Clock Lock Screen — one-click installer.
:: Downloads server.py from GitHub, installs to auto-startup.
:: Cleans up any existing instances before starting.

set "INSTALL_DIR=%APPDATA%\BigClock"
set "SCRIPT=%INSTALL_DIR%\server.py"
set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "VBS=%STARTUP%\BigClockServer.vbs"
set "DOWNLOAD_URL=https://raw.githubusercontent.com/bsb3166/big-clock/main/server.py"

echo.
echo  Big Clock Lock Screen Installer
echo  ================================
echo.

:: ---- Step 1: Check Python ----
echo  [1/5] Checking Python ...
for /f "delims=" %%i in ('where pythonw 2^>nul') do set "PYTHONW=%%i"
if "%PYTHONW%"=="" (
    echo  [ERROR] Python not found. Please install Python and add to PATH.
    echo          https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)
echo        Found: %PYTHONW%

:: ---- Step 2: Kill existing instances ----
echo  [2/5] Cleaning up old instances ...
set "KILLED=0"
for /f "tokens=5" %%p in ('netstat -ano 2^>nul ^| findstr "LISTENING" ^| findstr ":8888 "') do (
    taskkill /PID %%p /F >nul 2>&1
    if not errorlevel 1 set "KILLED=1"
)
:: Also kill any pythonw running server.py
for /f "tokens=2 delims=," %%p in ('wmic process where "name='pythonw.exe' and commandline like '%%server.py%%'" get processid /format:csv 2^>nul ^| findstr /r "[0-9]"') do (
    taskkill /PID %%p /F >nul 2>&1
    if not errorlevel 1 set "KILLED=1"
)
if "%KILLED%"=="1" (
    echo        Cleaned up old processes.
    timeout /t 1 /nobreak >nul
) else (
    echo        No old instances found.
)

:: ---- Step 3: Download server.py ----
echo  [3/5] Downloading server.py ...
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%SCRIPT%' -UseBasicParsing" 2>nul
if not exist "%SCRIPT%" (
    echo  [ERROR] Download failed. Check your internet connection.
    pause
    exit /b 1
)
echo        Saved to %INSTALL_DIR%

:: ---- Step 4: Add to startup ----
echo  [4/5] Adding to Windows startup ...
(
echo Set WshShell = CreateObject^("WScript.Shell"^)
echo WshShell.Run """%PYTHONW%"" ""%SCRIPT%"" --daemon", 0, False
) > "%VBS%"
echo        Auto-start enabled.

:: ---- Step 5: Start daemon ----
echo  [5/5] Starting lock screen service ...
start "" "%PYTHONW%" "%SCRIPT%" --daemon

:: Verify it started
timeout /t 2 /nobreak >nul
powershell -Command "try { $r = Invoke-WebRequest -Uri 'http://localhost:8888/api/health' -UseBasicParsing -TimeoutSec 3; exit 0 } catch { exit 1 }" 2>nul
if errorlevel 1 (
    echo  [WARN] Service may not have started correctly.
    echo         Try restarting your computer.
) else (
    echo        Service running on port 8888.
)

echo.
echo  ================================
echo  Done! Lock screen is ready.
echo  It will run silently on every login.
echo  ================================
echo.
pause
