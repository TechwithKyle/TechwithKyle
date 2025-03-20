<#
.SYNOPSIS
    This PowerShell script ensures that attachments must be prevented from being downloaded from RSS feeds.
    
.NOTES
    Author          : Kyle Barnes
    LinkedIn        : linkedin.com/in/kylenbarnes
    GitHub          : github.com/TechwithKyle
    Date Created    : 2025-03-20
    Last Modified   : 2025-03-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000295 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000295.ps1 
#>

# STIG WN10-CC-000295 - Disable Automatic Enclosure Downloads in Internet Explorer Feeds

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds"
$regName = "DisableEnclosureDownload"
$regValue = 1

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    Write-Host "Creating registry path: $regPath" -ForegroundColor Yellow
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value to disable enclosure downloads
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord

# Confirm the change
$updatedValue = Get-ItemProperty -Path $regPath -Name $regName
if ($updatedValue.$regName -eq $regValue) {
    Write-Host "Automatic enclosure downloads are now disabled." -ForegroundColor Green
} else {
    Write-Host "Failed to apply the setting. Please check permissions." -ForegroundColor Red
}
