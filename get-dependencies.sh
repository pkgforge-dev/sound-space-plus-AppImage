#!/bin/sh

set -eu

ARCH=$(uname -m)
BINARY="https://github.com/David20122/sound-space-plus/releases/latest/download/linux.zip"

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm sdl2 unzip

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Getting binary..."
echo "---------------------------------------------------------------"
if ! wget --retry-connrefused --tries=30 "$BINARY" -O /tmp/download.zip 2>/tmp/download.log; then
	cat /tmp/download.log
	exit 1
fi
awk -F'/' '/Location:/{print $(NF-1); exit}' /tmp/download.log > ~/version

mkdir -p ./AppDir/bin
unzip /tmp/download.zip -d ./AppDir/bin
chmod +x ./AppDir/bin/SoundSpacePlus."$ARCH"
