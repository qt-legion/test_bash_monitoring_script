#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 /path/to/dir/"
    exit 1
fi

TARGET_DIR="$1"

if [ ! -d "$TARGET_DIR" ]; then
    echo "$TARGET_DIR do not exist."
    exit 1
fi

mv "./script.sh" "$TARGET_DIR/"
chmod +x "$TARGET_DIR/script.sh"
echo "Success, script at $TARGET_DIR"

mv "./script.service" "/etc/systemd/system/"
sed -i "s|/path/to/script.sh|$TARGET_DIR/script.sh"
echo "Success, service at systemd"

mv "./script.timer" "/etc/systemd/system/"
echo "Success, timer at systemd"
