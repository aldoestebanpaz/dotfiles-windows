#!/usr/bin/env bash

set echo off
pushd "$(dirname "$0")" > /dev/null
source ../../linux/core/put.sh
source ../../linux/core/distro_check.sh
isUbuntuCheck

installCode() {
    # Install the vscode's apt repository and signing key
    if [ ! -e "/etc/apt/sources.list.d/vscode.list" ]; then
    wget -qO - https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    else
    put "vscode's repository already installed"
    fi

    # Update the repositories cache
    sudo apt update

    # code and chrome
    put "Installing 'code'"
    sudo apt -y install \
    code
}
if ! command -v code &> /dev/null
then
    installCode
else
    put "\"vscode\" found. Installation skipped."
fi

popd > /dev/null
