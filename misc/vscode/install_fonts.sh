#!/usr/bin/env bash

set echo off
pushd "$(dirname "$0")" > /dev/null
source ../../linux/core/temp/temp_begin.sh

# Extracted from "Install a nerd font on ubuntu"
# see https://gist.github.com/matthewjberger/7dd7e079f282f8138a9dc3b045ebefa0
#   /usr/local/share/fonts/ to install fonts system-wide
#   ~/.local/share/fonts/ or ~/.fonts to install fonts just for the current user
wget -P ${TMP_DIR} https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip
#cd /usr/local/share/fonts/ && unzip Meslo.zip && rm *Windows* && rm Meslo.zip
unzip ${TMP_DIR}/CascadiaCode.zip -d ~/.fonts
fc-cache -fv

popd > /dev/null



'CaskaydiaCove NFP Light'
=>
CaskaydiaCoveNerdFontPropo-Light