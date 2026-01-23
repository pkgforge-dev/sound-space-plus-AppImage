#!/bin/sh

set -eu

ARCH=$(uname -m)
export ARCH
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/David20122/sound-space-plus/refs/heads/nightly/assets/images/branding/icon.png
export DEPLOY_SDL=1
export DEPLOY_OPENGL=1

# Deploy dependencies
quick-sharun ./AppDir/bin/* /usr/lib/libnss_resolve.so*

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage
