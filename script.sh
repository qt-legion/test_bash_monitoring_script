#!/bin/bash

PROCESS_NAME="test"
LOG_FILE="/var/log/script.log"
API_URL="https://test.com/monitoring/test/api"

if pgrep -x "$PROCESS_NAME" > /dev/null; then
    if [ ! -f "$LOG_FILE.last.pid" ] || [ "$(pgrep -x "$PROCESS_NAME" | head -n 1)" != "$(cat "$LOG_FILE.last.pid")" ]; then
        echo $$ > "$LOG_FILE.last.pid"
        echo "$(date): $PROCESS_NAME restarted" >> "$LOG_FILE"
    fi
    if ! curl -s --head "$API_URL" | grep "200 OK" > /dev/null; then
        echo "$(date): Server inaccessible" >> "$LOG_FILE"
    fi
fi
