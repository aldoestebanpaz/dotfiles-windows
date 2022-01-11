# Profile for the Windows Powershell
# ===========

Push-Location $PSScriptRoot
$profileIncludeScripts = "components","functions","aliases","exports","prompt","extra"
$profileIncludeScripts | Where-Object { Test-Path "$_.ps1" } | ForEach-Object -process { Invoke-Expression ". .\$_.ps1" }
Pop-Location

# cls
