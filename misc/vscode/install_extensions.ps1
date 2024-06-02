# Run it through install_win_tools.ps1

param (
    [Parameter(Mandatory=$true)]
    [pscustomobject[]]$extensions
)

if (which code) {
    Write-Host "# vscode extensions" -ForegroundColor "Yellow"

    Foreach ($p in $extensions)
    {
        Write-Host "Installing `"$($p.Name)`"..." -ForegroundColor "Yellow"
        code --install-extension $p.Id
    }
    Remove-Variable extensions
}
