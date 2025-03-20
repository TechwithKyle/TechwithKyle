<#
.SYNOPSIS
    This PowerShell script ensures that Windows 10 must be configured to prioritize ECC Curves with longer key lengths first.
.NOTES
    Author          : Kyle Barnes
    LinkedIn        : linkedin.com/in/kylenbarnes
    GitHub          : github.com/TechwithKyle
    Date Created    : 2025-03-20
    Last Modified   : 2025-03-20
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000052 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\WN10-CC-000052.ps1 
#>

# STIG WN10-CC-000052 - Prioritize ECC Curves with Longer Key Lengths

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"
$regName = "EccCurves"
$regType = "MultiString"
$regValue = "NistP384", "NistP256"

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the setting
Set-ItemProperty -Path $regPath -Name $regName -Type $regType -Value $regValue

# Confirm the change
Write-Output "ECC Curve Prioritization policy has been applied successfully."
