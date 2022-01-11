# NOTE: PSReadline should be imported before PSFzf
if ((-not (Get-Module | Where-Object { $_.name -eq "PSReadLine" })) -and  (Get-Module -ListAvailable PSReadLine -ErrorAction SilentlyContinue) -ne $null) {
    Import-Module PSReadLine
}

if (((Get-Command fzf -ErrorAction SilentlyContinue) -ne $null) -and ((Get-Module -ListAvailable PSfzf -ErrorAction SilentlyContinue) -ne $null)) {
    Import-Module -Name PSfzf
}
