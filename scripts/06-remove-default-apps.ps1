#   Description:
# This script removes unwanted Apps that come with Windows. If you  do not want
# to remove certain Apps comment out the corresponding lines below.

Import-Module -DisableNameChecking $PSScriptRoot\..\lib\take-own.psm1
Import-Module -DisableNameChecking $PSScriptRoot\..\lib\force-mkdir.psm1

Write-Output "Elevating privileges for this process"
do {} until (Elevate-Privileges SeTakeOwnershipPrivilege)

Write-Output "Uninstalling default apps"
$apps = @(
    #-- Microsoft Internal Applications – Cannot be removed by standard means
    # 1527c705-839a-4832-9118-54d4Bd6a0c89_10.0.17134.1_neutral_neutral_cw5n1h2txyewy
    # c5e2524a-ea46-4f67-841f-6a9465d9d515_10.0.17134.1_neutral_neutral_cw5n1h2txyewy
    # E2A4F912-2574-4A75-9BB0-0D023378592B_10.0.17134.1_neutral_neutral_cw5n1h2txyewy
    # F46D4000-FD22-4DB4-AC8E-4E1DDDE828FE_10.0.17134.1_neutral_neutral_cw5n1h2txyewy
    # InputApp_1000.17134.1.0_neutral_neutral_cw5n1h2txyewy
    # Microsoft.AAD.BrokerPlugin_1000.17134.1.0_neutral_neutral_cw5n1h2txyewy
    # Microsoft.AccountsControl_10.0.17134.1_neutral__cw5n1h2txyewy
    # Microsoft.AsyncTextService_10.0.17134.1_neutral__8wekyb3d8bbwe
    # Microsoft.BioEnrollment_10.0.17134.1_neutral__cw5n1h2txyewy
    # Microsoft.CredDialogHost_10.0.17134.1_neutral__cw5n1h2txyewy
    # Microsoft.ECApp_10.0.17134.1_neutral__8wekyb3d8bbwe
    # Microsoft.LockApp_10.0.17134.1_neutral__cw5n1h2txyewy
    # Microsoft.MicrosoftEdgeDevToolsClient_1000.17134.1.0_neutral_neutral_8wekyb3d8bbwe
    # Microsoft.MicrosoftEdge_42.17134.1.0_neutral__8wekyb3d8bbwe
    #"Microsoft.PPIProjection_10.0.17134.1_neutral_neutral_cw5n1h2txyewy"
    # Microsoft.Win32WebViewHost_10.0.17134.1_7neutral_neutral_cw5n1h2txyewy
    # Microsoft.Windows.Apprep.ChxApp_1000.17134.1.0_neutral_neutral_cw5n1h2txyewy
    # Microsoft.Windows.AssignedAccessLockApp_1000.17134.1.0_neutral_neutral_cw5n1h2txyewy
    # Microsoft.Windows.CapturePicker_10.0.17134.1_neutral__cw5n1h2txyewy
    # Microsoft.Windows.CloudExperienceHost_10.0.17134.1_neutral_neutral_cw5n1h2txyewy
    # Microsoft.Windows.ContentDeliveryManager_10.0.17134.1_neutral_neutral_cw5n1h2txyewy
    # Microsoft.Windows.Cortana_1.10.7.17134_neutral_neutral_cw5n1h2txyewy
    # Microsoft.Windows.HolographicFirstRun_10.0.17134.1_neutral_neutral_cw5n1h2txyewy
    # Microsoft.Windows.OOBENetworkCaptivePortal_10.0.17134.1_neutral__cw5n1h2txyewy
    # Microsoft.Windows.OOBENetworkConnectionFlow_10.0.17134.1_neutral__cw5n1h2txyewy
    # Microsoft.Windows.ParentalControls_1000.17134.1.0_neutral_neutral_cw5n1h2txyewy
    # Microsoft.Windows.PeopleExperienceHost_10.0.1134.1_neutral_neutral_cw5n1h2txyewy
    # Microsoft.Windows.PinningConfirmationDialog_1000.17134.1.0_neutral__cw5n1h2txyewy
    # Microsoft.Windows.SecHealthUI_10.0.17134.1_neutral__cw5n1h2txyewy
    # Microsoft.Windows.SecureAssessmentBrowser_10.0.17134.1_neutral_neutral_cw5n1h2txyewy
    # Microsoft.XboxGameCallableUI_1000.17134.1.0_neutral_neutral_cw5n1h2txyewy
    # windows.immersivecontrolpanel_10.0.2.1000_neutral_neutral_cw5n1h2txyewy
    # Windows.PrintDialog_6.2.0.0_neutral_neutral_cw5n1h2txyewy
    #-- Libraries I want to keep
    # Microsoft.NET.Native.Runtime.1.7_1.7.25531.0_x64__8wekyb3d8bbwe
    # Microsoft.NET.Native.Framework.1.7_1.7.25531.0_x86__8wekyb3d8bbwe
    # Microsoft.VCLibs.140.00_14.0.25426.0_x86__8wekyb3d8bbwe
    # Microsoft.NET.Native.Runtime.1.6_1.6.24903.0_x86__8wekyb3d8bbwe
    # Microsoft.NET.Native.Framework.1.6_1.6.24903.0_x86__8wekyb3d8bbwe
    #-- Xbox functionality I want to keep
    # Microsoft.XboxGamingOverlay_1.15.1001.0_x64__8wekyb3d8bbwe
    # Microsoft.XboxSpeechToTextOverlay_1.21.13002.0_x64__8wekyb3d8bbwe
    # Microsoft.Xbox.TCUI_1.11.29001.0_x64__8wekyb3d8bbwe
    # Microsoft.XboxApp_41.41.18005.0_x64__8wekyb3d8bbwe
    # Microsoft.WindowsCalculator_10.1805.1201.0_x64__8wekyb3d8bbwe
    # Microsoft.XboxIdentityProvider_12.41.24002.0_x64__8wekyb3d8bbwe
    # Microsoft.XboxGameOverlay_1.30.5001.0_x64__8wekyb3d8bbwe
    #-- New OneNote application (the on included in Microsoft Office is 
    #-- deprecated going forward)
    # Microsoft.Office.OneNote_16001.10228.20003.0_x64__8wekyb3d8bbwe
    #-- Keeping the Microsoft Store as it is needed for Linux Subsystem
    #"Microsoft.WindowsStore_11804.1001.10.0_x64__8wekyb3d8bbwe"
    "Microsoft.StorePurchaseApp_11804.1001.9.0_x64__8wekyb3d8bbwe" # ???
    "Microsoft.Services.Store.Engagement_10.0.17112.0_x86__8wekyb3d8bbwe" # ???
    "Microsoft.Messaging_3.38.22001.0_x64__8wekyb3d8bbwe"
    "Microsoft.MicrosoftSolitaireCollection_4.0.1301.0_x86__8wekyb3d8bbwe"
    "Microsoft.Wallet_2.1.18009.0_x64__8wekyb3d8bbwe"
    "Microsoft.VCLibs.140.00.UWPDesktop_14.0.25426.0_x64__8wekyb3d8bbwe"
    "Microsoft.Microsoft3DViewer_4.1804.19012.0_x64__8wekyb3d8bbwe"
    "Microsoft.GetHelp_10.1706.10952.0_x64__8wekyb3d8bbwe"
    "Microsoft.BingWeather_4.24.11294.0_x64__8wekyb3d8bbwe"
    "Microsoft.WindowsAlarms_10.1805.1361.0_x64__8wekyb3d8bbwe"
    "Microsoft.SkypeApp_12.1815.209.0_x64__kzf8qxf38zg5c"
    "Microsoft.Microsoft3DViewer_4.1804.19012.0_x64__8wekyb3d8bbwe"
    "Microsoft.Print3D_2.0.10611.0_x64__8wekyb3d8bbwe"
    "Microsoft.Getstarted_6.10.10872.0_x64__8wekyb3d8bbwe"
    "Microsoft.OneConnect_4.1805.1291.0_x64__8wekyb3d8bbwe"
    "Microsoft.WindowsSoundRecorder_10.1805.1201.0_x64__8wekyb3d8bbwe"
    "Microsoft.WebMediaExtensions_1.0.10671.0_x64__8wekyb3d8bbwe"
    "Microsoft.MicrosoftStickyNotes_2.1.18.0_x64__8wekyb3d8bbwe"
    "Microsoft.WindowsCamera_2018.227.30.1000_x64__8wekyb3d8bbwe"
    "Microsoft.WindowsFeedbackHub_1.1712.1141.0_x64__8wekyb3d8bbwe"
    "Microsoft.MicrosoftOfficeHub_17.9328.1700.0_x64__8wekyb3d8bbwe"
    "Microsoft.DesktopAppInstaller_1.0.20921.0_x64__8wekyb3d8bbwe"
    "microsoft.windowscommunicationsapps_17.9330.20915.0_x64__8wekyb3d8bbwe"
    "Microsoft.ZuneMusic_10.18041.14611.0_x64__8wekyb3d8bbwe"
    "Microsoft.ZuneVideo_10.18041.14611.0_x64__8wekyb3d8bbwe"
    "Microsoft.People_10.1805.1361.0_x64__8wekyb3d8bbwe"
    "Microsoft.MSPaint_4.1805.15037.0_x64__8wekyb3d8bbwe"
    "Microsoft.Advertising.Xaml_10.1806.1.0_x86__8wekyb3d8bbwe"
    "Microsoft.Windows.Photos_2018.18041.15530.0_x64__8wekyb3d8bbwe"
    "Microsoft.WindowsMaps_5.1805.1431.0_x64__8wekyb3d8bbwe"
    "Microsoft.WindowsCalculator_10.1805.1201.0_x64__8wekyb3d8bbwe"
)

foreach ($app in $apps) {
    Write-Output "Trying to remove $app"
    remove-AppxPackage (Get-AppxPackage -AllUsers | Where {$_.PackageFullName -match "$app"}).PackageFullName

    Write-Output "Trying to remove $app online"
    Get-AppXProvisionedPackage -Online | Where-Object DisplayName -EQ "$app" | Remove-AppxProvisionedPackage -Online
}

# Prevents "Suggested Applications" returning
force-mkdir "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content"
Set-ItemProperty "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Cloud Content" "DisableWindowsConsumerFeatures" 1
