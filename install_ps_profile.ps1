Write-Host "Profile script: $profile"

$profileFile = Split-Path -Leaf $profile
$profileDir = Split-Path -Parent $profile
$componentsDir = Join-Path $profileDir "components"

Write-Host "Creating directory `"$profileDir`" and copying files inside..."
New-Item -Path $profileDir -ItemType Directory -Force | Out-Null
Copy-Item -Path .\ps-profile\*.ps1 -Destination $profileDir # -Exclude "bootstrap.ps1"

Write-Host "Renaming profile.ps1..."
if (Test-Path $profile) { Remove-Item $profile }
Rename-Item -Path (Join-Path $profileDir -ChildPath "profile.ps1") -NewName $profileFile

Write-Host "Creating directory `"$componentsDir`" and copying files inside..."
New-Item -Path $componentsDir -ItemType Directory -Force | Out-Null
Copy-Item -Path .\ps-profile\components\** -Destination $componentsDir -Include **

Remove-Variable profileFile
Remove-Variable profileDir
Remove-Variable componentsDir
