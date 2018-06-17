Import-Module -DisableNameChecking $PSScriptRoot\..\lib\force-mkdir.psm1
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1

force-mkdir "HKCU:\Software\Policies\Microsoft\Windows\Explorer"
Set-ItemProperty "HKCU:\Software\Policies\Microsoft\Windows\Explorer" "DisableNotificationCenter" 1
