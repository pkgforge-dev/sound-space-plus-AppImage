#!/bin/sh

set -eux

ARCH="$(uname -m)"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"
VERSION="$(cat ~/version)"

export OUTPUT_APPIMAGE=1
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=https://raw.githubusercontent.com/David20122/sound-space-plus/refs/heads/nightly/assets/images/branding/icon.png
export OUTNAME=SoundSpacePlus-"$VERSION"-anylinux-"$ARCH".AppImage
export DEPLOY_SDL=1
export DEPLOY_OPENGL=1
export DEPLOY_PIPEWIRE=1

# DEPLOY ALL LIBS
wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun
./quick-sharun ./AppDir/bin/*

mkdir -p ./dist
mv -v ./*.AppImage*  ./dist
mv -v ~/version      ./dist

echo "All Done!"
