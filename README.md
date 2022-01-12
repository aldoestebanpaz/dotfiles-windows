# dotfiles-windows

Here are the configuration files of my Windows working environment.

* [Installation](#installation)
    * [Install requirements and updates for Windows PowerShell](#install-requirements-and-updates-for-windows-powershell)
    * [Install the Dracula color scheme](#install-the-dracula-color-scheme)
    * [Install the PowerShell profile](#install-the-powershell-profile)
    * [Install home configuration files](#install-home-configuration-files)
    * [Configure some Windows defaults](#configure-some-windows-defaults)
    * [Install the tools](#install-the-tools)
* [Miscellaneous files](#miscellaneous-files)
* [delta configurations for better diffs](#delta-configurations-for-better-diffs)
* [TODOS](#todos)
* [References](#references)

## Installation

NOTE: For all the installations listed bellow, you need to open a Powershell terminal as Administrator.

1. Start Windows PowerShell with the "Run as Administrator" option (Only members of the Administrators group on the computer can change the execution policy) and `cd` to the directory.
2. Enable running unsigned scripts with the following command:
```powershell
Set-ExecutionPolicy unrestricted
```
3. Execute the scripts for each subsection below and finally reopen the terminal if neccessary to be able to use all the profile configuration defined for PowerShell.

### Install requirements and updates for Windows PowerShell

The following script will install and update dependencies for the next installations.

```powershell
.\install_ps_tools.ps1
```

### Install the Dracula color scheme

NOTE: This step is only necessary if you want to change the appearance of the native Windows PowerShell terminal. If you plan to always use the Windows Terminal then skip this step.

When the following script finishes his execution, you will need to close and open a the shell again in order to see the final result.

```powershell
.\install_color_scheme.ps1
```

### Install the PowerShell profile

NOTE: You need to install the PowerShell profile before to continue with the next installation scripts. Use the following for installing the profile using the Windows PowerShell shell and using the PowerShell Core shell.

1. Copy .\ps-profile\extras.ps1.example as .\ps-profile\extras.ps1 and modify it.

Extras is designed to augment or override, the existing settings, functions and aliases. Here you can add your custom commands, including those you don't want to commit that could include sensitive data. E.g. a .\ps-profile\extra.ps1 could look like this:

```powershell
Set-Environment "EMAIL" "Aldo Esteban Paz <my@email.com>"

Set-Environment "GIT_AUTHOR_NAME" "apaz","User"
Set-Environment "GIT_COMMITTER_NAME" $env:GIT_AUTHOR_NAME
git config --global user.name $env:GIT_AUTHOR_NAME
Set-Environment "GIT_AUTHOR_EMAIL" "my@email.com"
Set-Environment "GIT_COMMITTER_EMAIL" $env:GIT_AUTHOR_EMAIL
git config --global user.email $env:GIT_AUTHOR_EMAIL

# Credentials
# Not in the repository, to prevent people from accidentally committing under my name
```

2. Execute the install_ps_profile script:

```powershell
.\install_ps_profile.ps1
```

3. Close and reopen the shell.

### Install home configuration files

Execute the install_home_configs script:

```powershell
.\install_home_configs.ps1
```

### Configure some Windows defaults

The following is to set some Windows defaults and features, such as showing hidden files in Windows Explorer.

1. Edit .\configure_windows.ps1 and set the machine name and full user name.
2. Execute the configure_windows script:
```powershell
.\configure_windows.ps1
```

### Install the tools

The following is for installing some common packages, utilities, and dependencies.

Read and Execute the install_win_tools script - remember to execute under an elevated shell:

```powershell
.\install_win_tools.ps1
```

## Miscellaneous files

The `misc` directory contains configuration files for different tools like Windows Terminal and Visual Studio Code. If needed you will have to apply these configurations manually.

## delta configurations for better diffs

The .gitconfig file in this repo is configured to use 'delta' as a diff tool.

Once you've installed the file in you hoe directory, you can run `delta --diff-so-fancy --show-config` to see the effective configuration values that this tool will be using when you run for example `git diff`.

Reference: https://github.com/dandavison/delta

## TODOS

- Install and configure .NET SDK, Java SE (JDK), maven, MSYS2, Ruby, perl, vim or neovim or gvim.

## References

- https://dotfiles.github.io/
- https://github.com/webpro/awesome-dotfiles
- https://github.com/jayharris/dotfiles-windows
