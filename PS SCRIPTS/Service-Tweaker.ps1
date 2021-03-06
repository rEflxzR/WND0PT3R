################################################ DISABLE WINDOWS SERVICES #########################################################
$services = @(
    'AdobeARMservice'
    'AJRouter'
    'ApHidMonitorService'
    'AdobeFlashPlayerUpdateSvc'
    'Apple Mobile Device'
    'bthserv'
    'CertPropSvc'
    'DiagTrack'
    'Fax'
    'HomeGroupListener'
    'HomeGroupProvider'
    'lfsvc'
    'MSiSCSI'
    'MapsBroker'
    'Spooler'
    'SCardSvr'
    'SCPolicySvc'
    'TrkWks'
    'TapiSrv'
    'TabletInputService'
    'seclogon'
    'WbioSrvc'
    'RemoteAccess'
    'XblAuthManager'
    'XblGameSave'
    'XboxNetApiSvc'
)

Write-Output "`n`n 1) Disabling Services"
Start-Sleep -Seconds 3

foreach($service in $services)
{
    Set-Service -Name "$service" -StartupType Disabled | Out-Null
    Start-Sleep -Seconds 1
}

################################################# DISABLE BACKGROUND APPS #########################################################
cls
Write-Output "`n`n 2) Disabling BACKGROUND APPS"

New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' -ItemType Directory -Force | Out-Null
Start-Sleep -Seconds 1
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy' -Name LetAppsRunInBackground -Value 2 -PropertyType DWord -Force | Out-Null

Start-Sleep -Seconds 3

New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications' -Name GlobalUserDisabled -Value 0 -PropertyType DWord -Force | Out-Null
Start-Sleep -Seconds 1
New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Search' -Name BackgroundAppGlobalToggle -Value 1 -PropertyType DWord -Force | Out-Null

################################################## DISABLE STARTUP APPS ###########################################################
cls
Write-Output "`n`n 3) Disabling Startup APPS"

Remove-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Run' -Name '*' -Force | Out-Null
Start-Sleep -Seconds 1
Remove-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce' -Name '*' -Force | Out-Null

Start-Sleep -Seconds 3

Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Run' -Name '*' -Force | Out-Null
Start-Sleep -Seconds 1
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\RunOnce' -Name '*' -Force | Out-Null

#################################################### DISABLE CORTANA ##############################################################
cls
Write-Output "`n`n 4) Trying to Disable CORTANA"
Start-Sleep -Seconds 2

New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -ItemType Directory -Force | Out-Null
Start-Sleep -Seconds 1
New-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search' -Name AllowCortana -Value 0 -PropertyType DWord -Force | Out-Null

############################################### DISABLE LIVE TILE NOTIFICATION ####################################################
cls
Write-Output "`n`n 5) Disabling Live Tile Notification"
Sleep -Seconds 2

New-Item -Path 'HKCU:\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications' -ItemType Directory -Force | Out-Null
Start-Sleep -Seconds 1
New-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Windows\CurrentVersion\PushNotifications' -Name NoTileApplicationNotification -Value 1 -PropertyType DWord -Force | Out-Null
Write-Output "`n  ALL DONE !!!`n"
