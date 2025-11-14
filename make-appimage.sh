#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q veracrypt | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/veracrypt/VeraCrypt/refs/heads/master/src/Resources/Icons/VeraCrypt-256x256.png
export DESKTOP=https://raw.githubusercontent.com/veracrypt/VeraCrypt/refs/heads/master/src/Setup/Linux/veracrypt.desktop

# Deploy dependencies
quick-sharun /usr/bin/veracrypt

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
