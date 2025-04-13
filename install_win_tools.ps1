# This script installs the following tools and applications:
#
# Core Tools:
# - Windsurf (Latest from the official website) - The alternative to vscode with a powerful AI
# - PowerShell Core (v7.5.0) - A cross-platform, open-source version of PowerShell
# - Chocolatey (Latest from chocolatey.org) - A package manager for Windows
# - Winget (Latest from GitHub) - Another package manager for Windows
#
# Windsurf Extensions:
# - Trailing Spaces (Latest from marketplace) - For removing trailing spaces
# - Diff Tool (Latest from marketplace) - For comparing files
# - Markdown All in One (Latest from marketplace) - For Markdown management
# - Bundle Size (Latest from marketplace) - For displaying the size of npm packages
# - Git Graph (Latest from marketplace) - For visualizing git history
# - Astro (Latest from marketplace) - Language tools for Astro
#
# System Tools:
# - Sysinternals Suite (Latest from chocolatey) - A collection of tools for system administrators
# - FFmpeg (Latest from chocolatey) - A multimedia framework
# - WinFetch (Latest from chocolatey) - A command-line tool for fetching system information
#
# CLI Tools:
# - Vim (Latest from chocolatey) - A CLI text editor
# - Ripgrep (rg) (Latest from chocolatey) - For searching text using regular expressions
# - cURL (Latest from chocolatey) - For making HTTP requests
# - Less (Latest from chocolatey) - For navigating through long text
# - jq (Latest from chocolatey) - A JSON processor
# - yq (Latest from chocolatey) - A YAML processor
# - bat (Latest from chocolatey) - A cat clone
# - NVM for Windows (Latest from chocolatey) - A Node Version Manager
# - Delta (Latest from chocolatey) - A git diff viewer
# - Glow (Latest from chocolatey) - A markdown reader
# - fzf (Latest from chocolatey) - A fuzzy finder
#
# Fonts:
# - Caskaydia Cove Nerd Font (Latest from chocolatey) - A monospace font with programming ligatures
# - Fira Code (Latest from chocolatey) - Another monospace font with programming ligatures
# - Source Code Pro (Latest from chocolatey) - Another monospace font, but without ligatures
#
# Applications:
# - Telegram (Latest from chocolatey) - A messaging app
# - HxD (Latest from chocolatey) - A hex editor
#
# Node.js Components:
# - Node.js (Latest LTS version via NVM)
# - pnpm (Latest via winget) - A fast, disk space efficient alternative to npm
# - Yarn (Latest via npm) - Another package manager for Node.js (I use it for old projects)
# - Live Server (Latest via npm) - A live server for static files (I use it with Windsurf)
#
# Vim Components:
# - vim-plug (Latest from GitHub) - A plugin manager for Vim
#
# Tools installed with Winget:
# - Windows Terminal (Latest from winget) - A modern terminal
# - WinMerge (Latest from winget) - A diff and merge tool
# - Git (Latest from winget) - A distributed version control system
# - Postman (Latest from winget) - A API development tool
# - Python (Latest from winget) - A programming language
# - .NET SDK (Latest from winget) - A development platform
# - pnpm (Latest from winget) - A fast, disk space efficient alternative to npm
# - LightShot (Latest from winget) - A screenshot tool
# - ScreenToGif (Latest from winget) - Screen, webcam and sketchboard recorder to create GIFs
# - 7-Zip (Latest from winget) - File archiver
# - GIMP (Latest from winget) - Image editor
# - Google Chrome (Latest from winget) - A Web browser
# - VLC Media Player (Latest from winget) - A Media player
# - qBittorrent (Latest from winget) - A Torrent client

# Some scripts and commands were extracted from the following links:
# - https://dev.to/smashse/wsl-chocolatey-powershell-winget-1d6p
# - https://stackoverflow.com/questions/4753051/how-do-i-check-if-a-particular-msi-is-installed

# Check to see if we are currently running "as Administrator"
if (!(Verify-Elevated)) {
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);

    exit
}

# Create temp directory for downloaded stuff
$tempdir = ".\temp"
## Remove-Item -LiteralPath $tempdir -Recurse -Force
Get-ChildItem -Path $tempdir -Recurse | Remove-Item -Recurse -Force
If(!(test-path $tempdir))
{
    New-Item -ItemType Directory -Path $tempdir -Force | Out-Null
}

Write-Host "# core tools" -ForegroundColor "Yellow"

# Windsurf (https://windsurf.com/) - The alternative to vscode with a powerful AI
if (-not (Get-Package -Provider Programs | Where-Object {$_.Name -like "*Windsurf*"})) {
    Write-Host "Installing `"Windsurf`"..." -ForegroundColor "Yellow"

    $apiResponse = Invoke-RestMethod -Uri "https://windsurf-stable.codeium.com/api/update/win32-x64-user/stable/latest"
    $downloadUrl = $apiResponse.url

    Invoke-WebRequest -Uri $downloadUrl -OutFile "$tempdir\windsurf_installer.exe"

    # Run the installer
    Start-Process -FilePath "$tempdir\windsurf_installer.exe" -Wait
}
else {
    Write-Host "`"Windsurf`" found." -ForegroundColor "Yellow"
}

# windsurf extensions
$windsurfExtensions = @(
    ## Miscellaneous
    ## -----------------------
    # Trailing Spaces (https://github.com/shardulm94/vscode-trailingspaces)
    [pscustomobject]@{ Name="Trailing Spaces"; Id="shardulm94.trailing-spaces" }
    # Diff Tool (https://github.com/jinsihou19/vscode-diff-tool)
    [pscustomobject]@{ Name="Diff Tool"; Id="jinsihou.diff-tool" }
    # Markdown All in One (https://github.com/yzhang-gh/vscode-markdown)
    [pscustomobject]@{ Name="Markdown All in One"; Id="yzhang.markdown-all-in-one" }
    # Display the bundle size of npm packages (https://github.com/ambar/vscode-bundle-size)
    [pscustomobject]@{ Name="Bundle Size"; Id="ambar.bundle-size" }
    # An interactive git graph viewer (https://github.com/mhutchie/vscode-git-graph)
    [pscustomobject]@{ Name="Git Graph"; Id="mhutchie.git-graph" }
    # Astro (https://github.com/withastro/language-tools) - Language tools for Astro
    [pscustomobject]@{ Name="Astro"; Id="astro-build.astro-vscode" }
)
.\misc\windsurf\install_extensions.ps1 -Extensions $windsurfExtensions

# PowerShell Core (https://github.com/PowerShell/PowerShell)
if(-not (Get-Uninstalls | Where-Object { $_.PSChildName -eq "{11E117C7-01D0-4C4E-9096-2E90843A173E}" })) {
    Write-Host "Installing `"Powershell Core`"..." -ForegroundColor "Yellow"
    Exit
    &Invoke-WebRequest `
        -Uri "https://github.com/PowerShell/PowerShell/releases/download/v7.5.0/PowerShell-7.5.0-win-x64.msi" `
        -OutFile "$tempdir\PowerShellCore.msi" `
        -UseBasicParsing
    # Run `msiexec /?` to see options that msiexec accepts.
    # Run `msiexec /log logfile.txt /package PowerShellCore.msi` and see logfile.txt for configurable "property" values in this msi package.
    &msiexec `
        /package "$tempdir\PowerShellCore.msi" `
        /quiet `
        ADD_PATH=1 `
        REGISTER_MANIFEST=1 `
        ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 `
        ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1
}
else {
    Write-Host "`"Powershell Core`" found." -ForegroundColor "Yellow"
}

# Chocolatey (https://chocolatey.org/)
choco -v | Out-Null
if(-not $?) {
    Write-Host "Installing `"Chocolatey`"..." -ForegroundColor "Yellow"
    Write-Host ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    &Set-ExecutionPolicy Bypass -Scope Process -Force; `
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
        iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    Write-Host "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
    Refresh-Environment
}
else {
    Write-Host "`"Chocolatey`" found." -ForegroundColor "Yellow"
}

# Install Winget
.\misc\winget\install

Write-Host "# chocolatey packages" -ForegroundColor "Yellow"
$chocoPackages = @(
    ## System tools
    ## -----------------------
    # sysinternals (https://technet.microsoft.com/en-us/sysinternals/bb842062)
    [pscustomobject]@{ Name="sysinternals"; Id="sysinternals" }
    # ffmpeg (https://www.ffmpeg.org/)
    [pscustomobject]@{ Name="ffmpeg"; Id="ffmpeg" }
    # winfetch (https://github.com/kiedtl/winfetch)
    [pscustomobject]@{ Name="winfetch"; Id="winfetch" }

    ## CLI tools
    ## -----------------------
    # vim (https://www.vim.org/)
    [pscustomobject]@{ Name="vim"; Id="vim" }
    # ripgrep (https://github.com/BurntSushi/ripgrep)
    [pscustomobject]@{ Name="ripgrep (rg, A search tool that combines the usability of ag with the raw speed of grep)"; Id="ripgrep" }
    # curl (https://curl.se/)
    [pscustomobject]@{ Name="curl"; Id="curl" }
    # less (http://www.greenwoodsoftware.com/less/)
    [pscustomobject]@{ Name="less"; Id="less" }
    # jq (https://stedolan.github.io/jq/)
    [pscustomobject]@{ Name="jq (Command-line JSON processor)"; Id="jq" }
    # yq (https://mikefarah.gitbook.io/yq/)
    [pscustomobject]@{ Name="yq (Command-line YAML processor)"; Id="yq" }
    # bat (https://github.com/sharkdp/bat)
    [pscustomobject]@{ Name="bat (A cat clone)"; Id="bat" }
    # nvm (https://github.com/coreybutler/nvm-windows)
    [pscustomobject]@{ Name="NVM for Windows"; Id="nvm" }
    # delta (https://github.com/dandavison/delta)
    [pscustomobject]@{ Name="delta (A syntax-highlighter for git and diff output)"; Id="delta" }
    # glow (https://github.com/charmbracelet/glow)
    [pscustomobject]@{ Name="glow (a terminal based markdown reader)"; Id="glow" }
    # fzf (https://github.com/junegunn/fzf)
    [pscustomobject]@{ Name="fzf (a fuzzy finder)"; Id="fzf" }

    ## Nerd Fonts
    ## -----------------------
    ## More fonts with glyphs: https://github.com/ryanoasis/nerd-fonts#patched-fonts
    # Caskaydia Cove Nerd Font (aka. CascadiaCode Nerd Font) (https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode)
    # Installation: https://github.com/ryanoasis/nerd-fonts#option-1-download-and-install-manually
    [pscustomobject]@{ Name="Caskaydia Cove Nerd Font"; Id="cascadia-code-nerd-font" }

    ## Other Fonts
    ## -----------------------
    # Fira Code (https://github.com/tonsky/FiraCode)
    # Unfortunately there is not a package with the patched version from Nerd Fonts: https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/FiraCode
    # Installation for vscode: https://github.com/tonsky/FiraCode/wiki/VS-Code-Instructions
    [pscustomobject]@{ Name="Fira Code (a monospaced font with programming ligatures)"; Id="firacode" }
    # Source Code Pro (https://github.com/adobe-fonts/source-code-pro)
    [pscustomobject]@{ Name="Source Code Pro (a set of OpenType fonts designed for better reading in GUIs)"; Id="sourcecodepro" }

    ## Misc
    ## -----------------------
    # Colour Contrast Analyser (CCA) (https://github.com/ThePacielloGroup/CCAe)
    # A colour picker and contrast ratio checker with WCAG compliance indicators for accessibility
    # This tool is the best alternative to Pika (https://github.com/superhighfives/pika) I've found for Windows
    [pscustomobject]@{ Name="Colour Contrast Analyser"; Id="colour-contrast-analyser" }
    # HxD (https://mh-nexus.de/en/hxd/)
    # A hex editor
    [pscustomobject]@{ Name="HxD"; Id="hxd" }
    # Discord (https://discord.com/)
    # A messaging app which excels in community building with features like voice channels and customizable servers
    [pscustomobject]@{ Name="Discord"; Id="discord" }
    # Telegram (https://desktop.telegram.org/)
    # A messaging app similar to WhatsApp with a focus on speed and security
    [pscustomobject]@{ Name="Telegram"; Id="telegram" }
)
if (which choco) {
    Foreach ($p in $chocoPackages)
    {
        $result = choco list --limit-output --local-only --exact --by-id-only $p.Id | Where-object { $_.ToLower().StartsWith($p.Id.ToLower()) }
        if($result -eq $null) {
            Write-Host "Installing `"$($p.Name)`"..." -ForegroundColor "Yellow"
            choco install -y --limit-output $p.Id
        }
        else {
            Write-Host "`"$($p.Name)`" found." -ForegroundColor "Yellow"
        }
    }
}
Remove-Variable chocoPackages

Refresh-Environment

Write-Host "# winget packages" -ForegroundColor "Yellow"
$wingetPackages = @(
    ## CLI tools
    ## -----------------------
    # Windows Terminal (https://github.com/Microsoft/Terminal)
    [pscustomobject]@{ Name="Windows Terminal"; Id="Microsoft.WindowsTerminal" }

    ## Dev tools
    ## -----------------------
    # WinMerge (https://winmerge.org/)
    [pscustomobject]@{ Name="WinMerge (an Open Source differencing and merging tool for Windows)"; Id="WinMerge.WinMerge" }
    # Microsoft Visual Studio Code (https://code.visualstudio.com/)
    # [pscustomobject]@{ Name="vscode"; Id="Microsoft.VisualStudioCode" }
    # Git (https://gitforwindows.org/)
    [pscustomobject]@{ Name="Git"; Id="Git.Git" }
    # Postman (https://www.postman.com/)
    [pscustomobject]@{ Name="Postman"; Id="Postman.Postman" }
    # Python (https://www.python.org/)
    [pscustomobject]@{ Name="Python 3"; Id="Python.Python.3" }
    # .NET SDK (https://dot.net/, https://docs.microsoft.com/en-us/dotnet/, https://docs.microsoft.com/en-us/dotnet/core/sdk, https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-install-script)
    [pscustomobject]@{ Name=".NET SDK"; Id="Microsoft.dotnet" }
    # pnpm (https://pnpm.io/) - A fast, disk space efficient alternative to npm
    [pscustomobject]@{ Name="pnpm"; Id="pnpm.pnpm" }

    ## Miscellaneous tools
    ## -----------------------
    # Greenshot (https://getgreenshot.org/) - I replaced it by LightShot
    # [pscustomobject]@{ Name="Greenshot"; Id="Greenshot.Greenshot" }
    # LightShot (https://app.prntscr.com/)
    [pscustomobject]@{ Name="LightShot"; Id="Skillbrains.Lightshot" }
    # ScreenToGif (https://www.screentogif.com/) - Screen, webcam and sketchboard recorder with an integrated editor
    # Alternatives:
    # - [ShareX](https://getsharex.com/)
    # - [LICEcap](https://www.cockos.com/licecap/)
    [pscustomobject]@{ Name="ScreenToGif"; Id="NickeManarin.ScreenToGif" }
    # 7-Zip (https://www.7-zip.org/)
    [pscustomobject]@{ Name="7zip"; Id="7zip.7zip" }
    # GIMP (https://www.gimp.org/)
    [pscustomobject]@{ Name="GIMP"; Id="GIMP.GIMP" }
    # Google Chrome (https://www.google.com/chrome/)
    [pscustomobject]@{ Name="Chrome"; Id="Google.Chrome" }
    # VLC Media Player (https://www.videolan.org/)
    [pscustomobject]@{ Name="VLC"; Id="VideoLAN.VLC" }
    # Mixxx (https://www.mixxx.org/)
    # [pscustomobject]@{ Name="MiXXX"; Id="MiXXX.MiXXX" }
    # qBittorrent (https://www.qbittorrent.org/)
    [pscustomobject]@{ Name="qBittorrent"; Id="qBittorrent.qBittorrent" }
)
if (which winget) {
    Foreach ($p in $wingetPackages)
    {
        winget list --exact --id $p.Id | Out-Null
        if(-not $?) {
            Write-Host "Installing `"$($p.Name)`"..." -ForegroundColor "Yellow"
            winget install --exact --id $p.Id
        }
        else {
            Write-Host "`"$($p.Name)`" found. Installation skipped." -ForegroundColor "Yellow"
        }
    }
}
Remove-Variable wingetPackages

Refresh-Environment

# Invoke-Expression -Command ""

# VS Code Extensions:
# - Trailing Spaces (Latest from marketplace) - For removing trailing spaces
# - Diff Tool (Latest from marketplace) - For comparing files
# - Markdown All in One (Latest from marketplace) - For Markdown management
# - Bundle Size (Latest from marketplace) - For displaying the size of npm packages
# - Git Graph (Latest from marketplace) - For visualizing git history
# vscode extensions
# $vscodeExtensions = @(
#     ## Miscellaneous
#     ## -----------------------
#     # Trailing Spaces (https://github.com/shardulm94/vscode-trailingspaces)
#     [pscustomobject]@{ Name="Trailing Spaces"; Id="shardulm94.trailing-spaces" }
#     # Diff Tool (https://github.com/jinsihou19/vscode-diff-tool)
#     [pscustomobject]@{ Name="Diff Tool"; Id="jinsihou.diff-tool" }
#     # Markdown All in One (https://github.com/yzhang-gh/vscode-markdown)
#     [pscustomobject]@{ Name="Markdown All in One"; Id="yzhang.markdown-all-in-one" }
#     # Display the bundle size of npm packages (https://github.com/ambar/vscode-bundle-size)
#     [pscustomobject]@{ Name="Bundle Size"; Id="ambar.bundle-size" }
#     # An interactive git graph viewer (https://github.com/mhutchie/vscode-git-graph)
#     [pscustomobject]@{ Name="Git Graph"; Id="mhutchie.git-graph" }
# )
# .\misc\vscode\install_extensions.ps1 -Extensions $vscodeExtensions


# NodeJS setup
if ((which nvm) -and (which choco)) {
    Write-Host "# nvm components" -ForegroundColor "Yellow"
    ## Install latest nodeJS version
    nvm on
    nvm install lts
    nvm use lts
    Write-Host "Installing Node Packages..." -ForegroundColor "Yellow"
    if (which npm) {
        npm update npm
        npm install -g yarn
        npm install -g live-server
        # npm install -g gulp
        # npm install -g mocha
        # npm install -g node-inspector
        # npm install -g yo
    }
}
# Get the latest version of pnpm
pnpm self-update

# Ruby Setup
# if (which gem) {
#     gem pristine --all --env-shebang
# }

# VIM setup
if (which vim) {
    Write-Host "# Vim components" -ForegroundColor "Yellow"
    &Invoke-WebRequest `
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim `
        -UseBasicParsing |`
        New-Item $home/vimfiles/autoload/plug.vim -Force
    Write-Host "Installing Vim plugins..." -ForegroundColor "Yellow"
    vim -c 'PlugInstall --sync' -c 'qa'
    # Janus for vim
    # Write-Host "Installing Janus..." -ForegroundColor "Yellow"
    # if ((which curl) -and (which vim) -and (which rake) -and (which bash)) {
    #     curl.exe -L https://bit.ly/janus-bootstrap | bash
    # }
}

Remove-Variable tempdir
