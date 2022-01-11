if ((Get-Module -ListAvailable Terminal-Icons -ErrorAction SilentlyContinue) -ne $null) {
    Import-Module -Name Terminal-Icons
}

if ((Get-Module -ListAvailable oh-my-posh -ErrorAction SilentlyContinue) -ne $null) {
    Import-Module oh-my-posh
    Set-PoshPrompt -Theme "pure"
}