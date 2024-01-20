# PowerShell script to enable or revert the right-click context menu in Windows 11

# Ensure running as Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    Write-Warning "Please run this script as an Administrator!"
    exit
}

# Function to set the registry key for enabling the right-click context menu
function Enable-ContextMenu {
    Set-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -Value ""
    Write-Output "Right-click context menu has been enabled. Please restart your computer for the changes to take effect."
}

# Function to remove the registry key and revert to the default Windows 11 context menu
function Revert-ContextMenu {
    Remove-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)"
    Write-Output "Reverted to the default Windows 11 context menu. Please restart your computer for the changes to take effect."
}

# Check if the registry key is already set
$regKey = Get-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "(Default)" -ErrorAction SilentlyContinue

if ($regKey -and $regKey."(Default)" -eq "") {
    Write-Output "The right-click context menu is already enabled."
} else {
    # Show menu options to the user
    Write-Host "Select an option:"
    Write-Host "1: Enable traditional right-click context menu"
    Write-Host "2: Revert to default Windows 11 context menu"
    $choice = Read-Host "Enter your choice (1 or 2)"

    switch ($choice) {
        "1" { Enable-ContextMenu }
        "2" { Revert-ContextMenu }
        default { Write-Warning "Invalid choice. Please enter 1 or 2." }
    }
}
