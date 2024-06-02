# You can run either this script directly through ".\install_packages.ps1 -InstallDefaults $true|$false" or through install_win_tools.ps1


param (
    [Parameter(Mandatory=$true, HelpMessage= 'Specifies if install the list of packages of a default installation')]
    [bool]$InstallDefaults,

    [Parameter(Mandatory=$false)]
    [pscustomobject[]]$packages
)

$defaultInstallationPackages = @(
    ## Miscellaneous tools
    ## -----------------------
    # Greenshot (https://getgreenshot.org/) - I replaced it by LightShot
    # [pscustomobject]@{ Name="Greenshot"; Id="Greenshot.Greenshot" }
    # LightShot (https://app.prntscr.com/)
    [pscustomobject]@{ Name="LightShot"; Id="Skillbrains.Lightshot" }
    # 7-Zip (https://www.7-zip.org/)
    [pscustomobject]@{ Name="7zip"; Id="7zip.7zip" }
    # GIMP (https://www.gimp.org/)
    [pscustomobject]@{ Name="GIMP"; Id="GIMP.GIMP" }
    # Google Chrome (https://www.google.com/chrome/)
    [pscustomobject]@{ Name="Chrome"; Id="Google.Chrome" }
    # VLC Media Player (https://www.videolan.org/)
    [pscustomobject]@{ Name="VLC"; Id="VideoLAN.VLC" }
    # Mixxx (https://www.mixxx.org/)
    # [pscustomobject]@{ Name="MiXXX"; Id="MiXXX.MiXXX" }
    # qBittorrent (https://www.qbittorrent.org/)
    [pscustomobject]@{ Name="qBittorrent"; Id="qBittorrent.qBittorrent" }

    ## CLI tools
    ## -----------------------
    # Windows Terminal (https://github.com/Microsoft/Terminal)
    [pscustomobject]@{ Name="Windows Terminal"; Id="Microsoft.WindowsTerminal" }

    ## Dev tools
    ## -----------------------
    # WinMerge (https://winmerge.org/)
    [pscustomobject]@{ Name="WinMerge (an Open Source differencing and merging tool for Windows)"; Id="WinMerge.WinMerge" }
    # Microsoft Visual Studio Code (https://code.visualstudio.com/)
    [pscustomobject]@{ Name="vscode"; Id="Microsoft.VisualStudioCode" }
    # Git (https://gitforwindows.org/)
    [pscustomobject]@{ Name="Git"; Id="Git.Git" }
    # Postman (https://www.postman.com/)
    [pscustomobject]@{ Name="Postman"; Id="Postman.Postman" }
    # Python (https://www.python.org/)
    [pscustomobject]@{ Name="Python 3"; Id="Python.Python.3" }
    # .NET SDK (https://dot.net/, https://docs.microsoft.com/en-us/dotnet/, https://docs.microsoft.com/en-us/dotnet/core/sdk, https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script)
    [pscustomobject]@{ Name=".NET SDK"; Id="Microsoft.dotnet" }
)

function Install-Packages {
    param (
        [Parameter(Mandatory=$true)]
        [pscustomobject[]]$packages
    )

    if (which winget) {
        Foreach ($p in $packages)
        {
            winget list --exact --id $p.Id | Out-Null
            if(-not $?) {
                Write-Host "Installing `"$($p.Name)`"..." -ForegroundColor "Yellow"
                winget install --exact --id $p.Id
            }
            else {
                Write-Host "`"$($p.Name)`" found. Installation skipped." -ForegroundColor "Yellow"
            }
        }
    }
}

if (-not($packages -eq $null) -and -not($packages -eq $false) -and ($packages.count -gt 0)) {
    Write-Host "# Running winget packages installation for custom list." -ForegroundColor "Yellow"
    Install-Packages -Packages $packages
}

if ($InstallDefaults) {
    Write-Host "# Running winget packages installation for default list." -ForegroundColor "Yellow"
    Install-Packages -Packages $defaultInstallationPackages
}
Remove-Variable defaultInstallationPackages
