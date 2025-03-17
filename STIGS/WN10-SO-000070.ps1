<#
.SYNOPSIS
    This PowerShell script ensures that the machine inactivity limit must be set to 15 minutes, locking the system with the screensaver.

.NOTES
    Author          : Kyle Barnes
    LinkedIn        : linkedin.com/in/kylenbarnes
    GitHub          : github.com/TechwithKyle
    Date Created    : 2025-03-17
    Last Modified   : 2025-03-17
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000070 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-SO-000070.ps1 
#>

$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

$values = @{
    "ConsentPromptBehaviorAdmin" = 0x5
    "ConsentPromptBehaviorUser" = 0x3
    "DSCAutomationHostEnabled" = 0x2
    "EnableCursorSuppression" = 0x1
    "EnableFullTrustStartupTasks" = 0x2
    "EnableInstallerDetection" = 0x1
    "EnableLUA" = 0x1
    "EnableSecureUIAPaths" = 0x1
    "EnableUIADesktopToggle" = 0x0
    "EnableUwpStartupTasks" = 0x2
    "EnableVirtualization" = 0x1
    "PromptOnSecureDesktop" = 0x1
    "SupportFullTrustStartupTasks" = 0x1
    "SupportUwpStartupTasks" = 0x1
    "ValidateAdminCodeSignatures" = 0x0
    "dontdisplaylastusername" = 0x0
    "legalnoticecaption" = ""
    "legalnoticetext" = ""
    "scforceoption" = 0x0
    "shutdownwithoutlogon" = 0x1
    "undockwithoutlogon" = 0x1
    "InactivityTimeoutSecs" = 0x384
}

# Set registry values
foreach ($name in $values.Keys) {
    Set-ItemProperty -Path $registryPath -Name $name -Value $values[$name] -Type DWord -Force
}

# Create additional registry keys
$additionalKeys = @(
    "$registryPath\Audit",
    "$registryPath\UIPI",
    "$registryPath\UIPI\Clipboard",
    "$registryPath\UIPI\Clipboard\ExceptionFormats"
)

foreach ($key in $additionalKeys) {
    if (!(Test-Path $key)) {
        New-Item -Path $key -Force | Out-Null
    }
}

# Set Clipboard ExceptionFormats values
$clipboardPath = "$registryPath\UIPI\Clipboard\ExceptionFormats"
$clipboardValues = @{
    "CF_BITMAP" = 0x2
    "CF_DIB" = 0x8
    "CF_DIBV5" = 0x11
    "CF_OEMTEXT" = 0x7
    "CF_PALETTE" = 0x9
    "CF_TEXT" = 0x1
    "CF_UNICODETEXT" = 0xD
}

foreach ($name in $clipboardValues.Keys) {
    Set-ItemProperty -Path $clipboardPath -Name $name -Value $clipboardValues[$name] -Type DWord -Force
}

Write-Output "Registry settings applied successfully."
