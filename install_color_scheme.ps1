# Installs the dracula color scheme on the native Windows PowerShell shell (no PowerShell Core)
# Instructions: https://github.com/dracula/powershell/blob/master/INSTALL.md


# Create temp directory for downloaded stuff
$tempdir = ".\temp"
## Remove-Item -LiteralPath $tempdir -Recurse -Force
Get-ChildItem -Path $tempdir -Recurse | Remove-Item -Recurse -Force
If(!(test-path $tempdir))
{
    New-Item -ItemType Directory -Path $tempdir -Force | Out-Null
}

## ColorTool (https://github.com/microsoft/terminal/tree/main/src/tools/ColorTool)
## * ColorTool is a utility for helping to set the color palette of the Windows Console.
## * To install the latest release of this zip along with the dracula theme,
## go to https://github.com/dracula/powershell/blob/master/INSTALL.md
&Invoke-WebRequest `
    -Uri "https://raw.githubusercontent.com/waf/dracula-cmd/master/dist/ColorTool.zip" `
    -OutFile "$tempdir\ColorTool.zip" `
    -UseBasicParsing
Expand-Archive "$tempdir\ColorTool.zip" -DestinationPath "$tempdir" -Force
cmd.exe /C "cd $tempdir\ColorTool\ && .\install.cmd"
