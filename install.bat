@echo off
:: One-click install: adds Big Clock server to Windows auto-startup.
:: After install, server.py runs silently on every login.
:: The lock screen API (POST /api/lock) is always available.

set "STARTUP=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "SCRIPT=%~dp0server.py"
set "VBS=%STARTUP%\BigClockServer.vbs"

:: Find pythonw.exe (runs Python without console window)
for /f "delims=" %%i in ('where pythonw 2^>nul') do set "PYTHONW=%%i"
if "%PYTHONW%"=="" (
    echo [ERROR] pythonw.exe not found. Please install Python and add to PATH.
    pause
    exit /b 1
)

:: Create a VBS launcher that runs server.py silently via pythonw.exe
(
echo Set WshShell = CreateObject^("WScript.Shell"^)
echo WshShell.Run """%PYTHONW%"" ""%SCRIPT%"" --daemon", 0, False
) > "%VBS%"

echo.
echo [OK] Big Clock server installed to Windows startup.
echo     %VBS%
echo.
echo     The lock-screen API will run silently on every login.
echo     To uninstall, run uninstall.bat or delete the file above.
echo.

:: Also start it now
start "" "%PYTHONW%" "%SCRIPT%" --daemon
echo [OK] Server started in background (port 8888).
echo.
pause
