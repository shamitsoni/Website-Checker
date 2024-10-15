#!/usr/bin/bash

LOG="status.log"
TIME=$(date +"%Y-%m-%d %T")

while IFS=" " read -r NAME SITE; do
	if curl --output /dev/null --silent $SITE; then
		echo "$TIME: $NAME is Operational" >> "$LOG"
		echo "$NAME ----- Operational"
	else
		echo "$TIME: $NAME is Offline" >> "$LOG"
		echo "$NAME ----- Offline"
	fi
done < sites.txt
