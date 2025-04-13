# Run it through install_win_tools.ps1

param (
    [Parameter(Mandatory=$true)]
    [pscustomobject[]]$extensions
)

if (-not (Get-Package -Provider Programs | Where-Object {$_.Name -like "*Windsurf*"})) {
    Write-Host "# windsurf extensions" -ForegroundColor "Yellow"

    Foreach ($p in $extensions)
    {
        Write-Host "Installing `"$($p.Name)`"..." -ForegroundColor "Yellow"
        windsurf --install-extension $p.Id
    }
    Remove-Variable extensions
}
