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

# The archlinux package is missing the translation files!
mkdir -p ./AppDir/share/veracrypt/languages
git clone --depth 1 https://github.com/veracrypt/VeraCrypt.git ./VeraCrypt
cp -v ./VeraCrypt/Translations/* ./AppDir/share/veracrypt/languages
rm -rf ./VeraCrypt

# Turn AppDir into AppImage
quick-sharun --make-appimage

# test the final app
quick-sharun --test ./dist/*.AppImage
