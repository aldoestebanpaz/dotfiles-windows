#!/usr/bin/env bash

if type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    # Alternative command: OS=`cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }'`
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/system-release ]; then
    . /etc/system-release
    OS=$NAME
    VER=$VERSION_ID
elif [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/redhat-release ]; then
    # Red Hat, CentOS, etc.
    OS=`cat /etc/redhat-release |sed s/\ release.*//`
    # PSUEDONAME=`cat /etc/redhat-release | sed s/.*\(// | sed s/\)//`
    VER=`cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//`
elif [ -f /etc/gentoo-release ]; then
    # Gentoo.
    OS=Gentoo
elif [ -f /etc/SuSe-release ]; then
    # SuSE/etc.
    OS=SuSe
    VER=`cat /etc/SuSE-release | grep VERSION | sed s/.*=\ //`
elif [ -f /etc/issue ]; then
    # others.
    OS=`cat /etc/issue | tr "\n" ' ' | sed 's/\ \\n.*$//' | awk  '{ print $1 }'`
    VER=`cat /etc/issue | tr "\n" ' ' | sed 's/\ \\n.*$//' | awk  '{ print $2 }'`
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi


_isUbuntu() {
    [ "$OS" = "Ubuntu" ]
}
isUbuntuCheck() {
    if ! _isUbuntu; then
        err "Error: This is not a distro based on Ubuntu."
        exit 1
    fi
}
