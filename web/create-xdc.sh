#!/bin/sh

case "$1" in
    "-h" | "--help")
        echo "usage: ${0##*/} [PACKAGE_NAME]"
        exit
        ;;
    "")
        PACKAGE_NAME=${PWD##*/} # '##*/' removes everything before the last slash and the last slash
        ;;
    *)
        PACKAGE_NAME=${1%.xdc} # '%.xdc' removes the extension and allows PACKAGE_NAME to be given with or without extension
        ;;
esac

rm "$PACKAGE_NAME.xdc" 2> /dev/null
zip -9 --recurse-paths "$PACKAGE_NAME.xdc" --exclude \
    CNAME favicon.png version.json .last_build_id manifest.json \
    privacy_policy.html \
    icons/Icon-maskable* icons/Icon-512* \
    canvaskit/*.symbols canvaskit/wimp* canvaskit/skwasm* canvaskit/chromium \
    LICENSE README.md webxdc.js webxdc.d.ts "./*.sh" "./*.xdc" -- *

echo "success, archive contents:"
unzip -l "$PACKAGE_NAME.xdc"

# check package size
MAXSIZE=655360
size=$(wc -c < "$PACKAGE_NAME.xdc")
if [ "$size" -ge $MAXSIZE ]; then
    echo "WARNING: package size exceeded the limit ($size > $MAXSIZE)"
fi
