<#
.SYNOPSIS
    This PowerShell script ensures that the convenience PIN for Windows 10 must be disabled

.NOTES
    Author          : Kyle Barnes
    LinkedIn        : linkedin.com/in/kylenbarnes
    GitHub          : github.com/TechwithKyle
    Date Created    : 2025-03-20
    Last Modified   : 2025-03-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000370.ps1 
#>

# STIG WN10-CC-000370 - Disable Domain PIN Logon

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"
$regName = "AllowDomainPINLogon"
$regValue = 0

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    Write-Host "Creating registry path: $regPath" -ForegroundColor Yellow
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the registry setting to disable domain PIN logon
Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord

# Verify the change
$updatedValue = Get-ItemProperty -Path $regPath -Name $regName
if ($updatedValue.$regName -eq $regValue) {
    Write-Host "Domain PIN logon is now disabled (STIG WN10-CC-000370)." -ForegroundColor Green
} else {
    Write-Host "Failed to apply the setting. Please check permissions." -ForegroundColor Red
}
