#!/usr/bin/env bash

if [[ ! "$1" =~ ^LG[123]$ ]]; then
  echo "Usage: $0 [LG1|LG2|LG3]"
  exit 1
fi

# Download file to a tmp dir
TMPDIR=$(mktemp -d) && cd "$TMPDIR" || exit
curl -LO https://github.com/jimeh/emacs-liquid-glass-icons/raw/refs/heads/main/Resources/Assets.car
curl -Lo Emacs.icns "https://github.com/jimeh/emacs-liquid-glass-icons/raw/refs/heads/main/Resources/Emacs$1-Default.icns"

APPDIR="${2:-/Applications/Emacs.app}"

# Get realpath if it's a macOS alias,
# taken from https://stackoverflow.com/a/1330366
if [ -f "$APPDIR" ] && [ ! -L "$APPDIR" ]; then
    exec 6>&2
    exec 2>/dev/null
    APPDIR=$(osascript << EOF
tell application "Finder"
set theItem to (POSIX file "${APPDIR}") as alias
if the kind of theItem is "alias" then
get the posix path of ((original item of theItem) as text)
end if
end tell
EOF
)
fi

# Copy 
cp -f Assets.car Emacs.icns "$APPDIR/Contents/Resources/"

# Update plist
ICON_NAME="Emacs$1"
PLIST="$APPDIR/Contents/Info.plist"
/usr/libexec/PlistBuddy -c "Set :CFBundleIconName $ICON_NAME" "$PLIST" 2>/dev/null \
    || /usr/libexec/PlistBuddy -c "Add :CFBundleIconName string $ICON_NAME" "$PLIST"

# Clear icon cache and restart Dock to show our new icon
rm /var/folders/*/*/*/com.apple.dock.iconcache
rm -rf /var/folders/*/*/*/com.apple.iconservices*
killall Dock

echo "If the new Emacs icon in the Dock has not changed, restart Emacs to take effect."
