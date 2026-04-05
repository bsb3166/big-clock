@echo off
:: Remove Big Clock server from Windows auto-startup.

set "VBS=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\BigClockServer.vbs"

if exist "%VBS%" (
    del "%VBS%"
    echo [OK] Big Clock server removed from startup.
) else (
    echo [INFO] Not installed — nothing to remove.
)

:: Kill any running instance
taskkill /f /im pythonw.exe /fi "WINDOWTITLE eq *server.py*" >nul 2>&1
echo [OK] Done.
echo.
pause
