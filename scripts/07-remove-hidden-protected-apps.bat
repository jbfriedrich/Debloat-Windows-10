@echo off
cd /d "%~dp0"
..\contrib\install_wim_tweak.exe /o /l
CLS
echo Uninstalling the Connect app...
..\contrib\install_wim_tweak.exe /o /c "Microsoft-PPIProjection-Package" /r
echo The Connect app should be uninstalled.
echo Uninstalling Microsoft Windows Backup
..\contrib\install_wim_tweak.exe /o /c "Microsoft-Windows-Backup" /r
echo Microsoft Windows Backup should be uninstalled.
echo Uninstalling Windows Media Player
..\contrib\install_wim_tweak.exe /o /c "Microsoft-Windows-MediaPlayer" /r
echo Windows Media Player should be uninstalled.
..\contrib\install_wim_tweak.exe /h /o /l
echo Please reboot Windows 10.
pause
