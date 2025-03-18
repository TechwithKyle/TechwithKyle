<#
.SYNOPSIS
    This PowerShell script ensures that Windows 10 must be configured to audit other Logon/Logoff Events Failures.

.NOTES
    Author          : Kyle Barnes
    LinkedIn        : linkedin.com/in/kylenbarnes
    GitHub          : github.com/TechwithKyle
    Date Created    : 2025-03-18
    Last Modified   : 2025-03-18
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000565 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-AU-000565.ps1 
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Audit"

# Ensure the registry path exists
if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set registry value for Other Logon/Logoff Events - Failure auditing enabled
Set-ItemProperty -Path $regPath -Name "Other Logon/Logoff Events" -Value 2 -Type DWord

# Enable the audit policy using auditpol
auditpol /set /subcategory:"Other Logon/Logoff Events" /failure:enable

Write-Output "Audit policy for Other Logon/Logoff Events Failures has been configured."
