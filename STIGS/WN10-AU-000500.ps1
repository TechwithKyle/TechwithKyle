<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Kyle Barnes
    LinkedIn        : linkedin.com/in/kylenbarnes
    GitHub          : github.com/TechwithKyle
    Date Created    : 2025-03-16
    Last Modified   : 2025-03-16 
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000500.ps1 
#>

# Define the registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"

# Define the property name and value (32MB in KB)
$propertyName = "MaxSize"
$propertyValue = 32768  # 0x00008000 in hexadecimal

# Check if the registry path exists, if not, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the MaxSize value
New-ItemProperty -Path $regPath -Name $propertyName -Value $propertyValue -PropertyType DWord -Force

# Confirm the change
Get-ItemProperty -Path $regPath | Select-Object $propertyName
