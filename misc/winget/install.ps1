# Windows Package Manager Client (aka winget.exe) (https://github.com/microsoft/winget-cli)
# You can run either this script directly or through install_win_tools.ps1


# Set current file location as working directory
Push-Location (Split-Path -parent $PSCommandPath)

# $tempdir provider
. ..\..\core\temp\begin_temp.ps1

# Extracted from "One Liner to Download the Latest Release from Github Repo"
# see https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
$versionLatestRelease = Invoke-RestMethod 'https://api.github.com/repos/microsoft/winget-cli/releases/latest' `
    | % assets `
    | ? name -like '*.msixbundle' `
    | % { $_.browser_download_url } `
    | Select-String -Pattern '^https://.*/releases/download/([^/]*)/.*$' `
    | % { $_.matches.groups[1].value }
if (-not (Get-AppxPackage -Name "Microsoft.DesktopAppInstaller") -or ($versionLatestRelease -ne (winget --version))) {
    Write-Host "Installing `"winget`"..." -ForegroundColor "Yellow"

    Invoke-RestMethod 'https://api.github.com/repos/microsoft/winget-cli/releases/latest' `
        | % assets `
        | ? name -like "*.msixbundle" `
        | % { Invoke-WebRequest $_.browser_download_url -OutFile "$tempdir\winget-cli.msixbundle" }

    Add-AppxPackage -Path "$tempdir\winget-cli.msixbundle"
}
else {
    Write-Host "`"winget`" found. Installation skipped." -ForegroundColor "Yellow"
}

. ..\..\core\temp\end_temp.ps1

Pop-Location
