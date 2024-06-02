$wingetPackages = @(
    # Git (https://gitforwindows.org/)
    [pscustomobject]@{ Name="Git"; Id="Git.Git" }
    # Microsoft Visual Studio Code (https://code.visualstudio.com/)
    [pscustomobject]@{ Name="vscode"; Id="Microsoft.VisualStudioCode" }
)
.\misc\winget\install_packages.ps1 -Packages $wingetPackages
