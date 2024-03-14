@echo off

powershell -command "Set-MpPreference -DisableRealtimeMonitoring $true"
:: Kill explorer.exe
taskkill /f /im explorer.exe

:: Take ownership of files

takeown /f %windir%\explorer.exe /r /d y
timeout /t 1 /nobreak >nul

:: Grant full control to Everyone

icacls %windir%\explorer.exe /grant Everyone:F /t

timeout /t 1 /nobreak >nul

:: Replace files




"%~dp0\unlock\IObitUnlocker.exe" /Delete /Normal "%windir%\explorer.exe"
timeout /t 1 /nobreak >nul

copy /y "%~dp0\explorer.exe" %windir%\explorer.exe
timeout /t 1 /nobreak >nul

icacls %windir%\explorer.exe /grant Everyone:F /t




timeout /t 1 /nobreak >nul

reg add "HKCU\Control Panel\Desktop" /v Wallpaper /t REG_SZ /d "%~dp0\wallpaper.jpeg" /f


REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V TaskbarSi /t REG_DWORD /D 0 /F

REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V TaskbarSizeMove /t REG_DWORD /D 1 /F
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V Start_ShowClassicMode /T REG_DWORD /D 1 /F
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /V SystemUsesLightTheme /t REG_DWORD /D 0 /F
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /V AppsUseLightTheme /t REG_DWORD /D 0 /F
REG ADD HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize /V EnableTransparency /t REG_DWORD /D 1 /F
reg add HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32 /f 
reg add HKCU\Software\Classes\CLSID\{d93ed569-3b3e-4bff-8355-3c44f6a52bb5}\InprocServer32 /f /ve
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V TaskbarSmallIcons /t REG_DWORD /D 1 /F
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowSuperHidden /t REG_DWORD /D 1 /F
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V TaskbarSD /t REG_DWORD /D 1 /F
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V ShowCortanaButton /t REG_DWORD /D 1 /F








start %~dp0\no_corners.exe


timeout /t 2 /nobreak >nul

start RUNDLL32.EXE user32.dll,UpdatePerUserSystemParameters


:: Restart explorer.exe
start %windir%\explorer.exe
start %windir%\explorer.exe

echo Replacement completed.
