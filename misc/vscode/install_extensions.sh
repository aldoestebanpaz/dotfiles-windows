#!/usr/bin/env bash

set echo off
pushd "$(dirname "$0")" > /dev/null
source ../../linux/core/put.sh

installExtensions() {
    put "Installing vscode extensions"
    # One Dark Pro
    code --install-extension zhuangtongfa.material-theme
    # Fluent Icons
    code --install-extension miguelsolorio.fluent-icons
    # :emojisense:
    code --install-extension bierner.emojisense
    # Image Preview
    code --install-extension kisstkondoros.vscode-gutter-preview
    # Image Viewer
    code --install-extension vscode-infra.image-viewer
    # Console Ninja
    code --install-extension wallabyjs.console-ninja
    # Error Lens
    code --install-extension usernamehw.errorlens
    # Git Lens
    code --install-extension eamodio.gitlens
    # Trailing Spaces
    code --install-extension shardulm94.trailing-spaces
    # Diff Tool
    code --install-extension jinsihou.diff-tool
    # Markdown All in One
    code --install-extension yzhang.markdown-all-in-one
}
if command -v code &> /dev/null
then
    installExtensions
else
    put "\"vscode\" NOT found. Installation of extensions skipped."
fi

popd > /dev/null
