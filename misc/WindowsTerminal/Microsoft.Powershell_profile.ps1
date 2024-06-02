# code $PROFILE
# <edit and then reload ...>
# . $PROFILE
# Profile for the Windows Powershell
# ===========

Push-Location $PSScriptRoot
$profileIncludeScripts = "components","functions","aliases","exports","prompt","extra"
$profileIncludeScripts | Where-Object { Test-Path "$_.ps1" } | ForEach-Object -process { Invoke-Expression ". .\$_.ps1" }
Pop-Location

# cls

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

oh-my-posh init pwsh --config "C:\Users\esteb\AppData\Local\Programs\oh-my-posh\themes\powerlevel10k_lean.omp.json" | Invoke-Expression
