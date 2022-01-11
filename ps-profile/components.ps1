# These components will be loaded for all PowerShell instances

Push-Location (Join-Path (Split-Path -parent $profile) "components")

# From within the ./components directory...
. .\console.ps1
. .\coreaudio.ps1
. .\posh_git.ps1
. .\fzf.ps1
. .\theme.ps1

Pop-Location
