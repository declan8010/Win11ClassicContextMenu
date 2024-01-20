@echo off
cls

:: Check if the script is running as Administrator
>nul 2>&1 net session || (
    echo You must run this script as Administrator.
    pause
    exit /b
)

:menu
cls
echo Choose an option:
echo 1. Enable Windows 10 Style context menu
echo 2. Restore default Windows 11 context menu
echo 3. Exit

:: Prompt the user to choose an option
set /p choice="Enter the number of your choice: "

:: Perform actions based on the user's choice
if "%choice%"=="1" (
    echo Enabling Windows 10 Style context menu...
    reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >nul 2>&1
    echo Windows 10 Style context menu has been enabled.
    goto restart_prompt
) else if "%choice%"=="2" (
    echo Restoring default Windows 11 context menu...
    reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f >nul 2>&1
    echo Default Windows 11 context menu has been restored.
    goto restart_prompt
) else if "%choice%"=="3" (
    exit /b
) else (
    echo Invalid choice. Please enter a valid option.
    pause
    goto menu
)

:restart_prompt
:: Prompt the user to restart
set /p restart="Restart your computer to apply the changes? (Y/N): "
if /i "%restart%"=="Y" (
    echo Restarting your computer...
    shutdown /r /t 0
) else if /i "%restart%"=="N" (
    echo You can restart your computer later to apply the changes.
) else (
    echo Invalid choice. Please enter Y or N.
    goto restart_prompt
)

:: Exit the script
pause
exit /b
