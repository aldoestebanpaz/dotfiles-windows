$ProgressPreference = "SilentlyContinue"

# Update Help for Modules
# Write-Host "# Updating Help for modules..." -ForegroundColor "Yellow"
# Write-Host ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
# Update-Help -Force
# Write-Host "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

# Install modules
Write-Host "# Installing modules..." -ForegroundColor "Yellow"
$psModules = @(
    # PowerShellGet (https://docs.microsoft.com/en-us/powershell/module/powershellget)
    # A module with commands for discovering, installing, updating and publishing PowerShell artifacts like Modules, DSC Resources, Role Capabilities, and Scripts.
    [pscustomobject]@{ Name="PowerShellGet"; Version="2.0" }
    # PSWindowsUpdate (https://www.powershellgallery.com/packages/PSWindowsUpdate)
    # This module contain cmdlets to manage Windows Update Client.
    [pscustomobject]@{ Name="PSWindowsUpdate" }
    # PSReadLine (https://github.com/PowerShell/PSReadLine)
    # A bash inspired readline implementation for PowerShell.
    [pscustomobject]@{ Name="PSReadLine"; Version="2.1" }
    # PSfzf (https://github.com/kelleyma49/PSFzf)
    # A PowerShell module that wraps fzf, a fuzzy file finder for the command line.
    [pscustomobject]@{ Name="PSfzf" }
    # posh-git (https://github.com/dahlbyk/posh-git)
    # A PowerShell environment for Git.
    [pscustomobject]@{ Name="posh-git" }
    # oh-my-posh (https://ohmyposh.dev/)
    # A prompt theme engine for any shell.
    [pscustomobject]@{ Name="oh-my-posh" }
    # Terminal-Icons (https://github.com/devblackops/Terminal-Icons)
    # A PowerShell module to show file and folder icons in the terminal.
    [pscustomobject]@{ Name="Terminal-Icons" }
)
Foreach ($p in $psModules)
{
    if ($p.Version -ne $null) {
        if (-not (Get-Module -ListAvailable | Where-Object { $_.Name -eq $p.Name -AND [Version]$_.Version -gt [Version]$p.Version })) {
            Write-Host "Installing the `"$($p.Name)`" module..." -ForegroundColor "Yellow"
            Install-Module -Name $p.Name -Force
        }
    }
    else {
        if (-not (Get-Module -ListAvailable | Where-Object { $_.Name -eq $p.Name })) {
            Write-Host "Installing the `"$($p.Name)`" module..." -ForegroundColor "Yellow"
            Install-Module -Name $p.Name -Force
        }
    }
}
Remove-Variable psModules

## PackageProvider: Nuget
if (-not (Get-PackageProvider | Where-Object { $_.Name -eq "NuGet" -AND [Version]$_.Version -GE [Version]"2.8.5.201" })) {
    Write-Host "Installing the `"Nuget`" package provider..." -ForegroundColor "Yellow"
    Install-PackageProvider -Name "NuGet" -Force | Out-Null
}

$ProgressPreference = "Continue"
