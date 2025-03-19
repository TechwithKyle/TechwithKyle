<#
.SYNOPSIS
    This PowerShell script ensures that the Local drives must be prevented from sharing with Remote Desktop Session Hosts.

.NOTES
    Author          : Kyle Barnes
    LinkedIn        : linkedin.com/in/kylenbarnes
    GitHub          : github.com/TechwithKyle
    Date Created    : 2025-03-19
    Last Modified   : 2024-03-19
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000275

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000275.ps1 
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"

# Ensure the registry path exists
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Disable drive redirection for RDSH
Set-ItemProperty -Path $regPath -Name "fDisableCdm" -Value 1 -Type DWord

Write-Output "Remote Desktop drive redirection has been disabled."
