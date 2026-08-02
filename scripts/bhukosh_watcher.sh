#!/bin/bash
# bhukosh_watcher.sh — poll Bhukosh (GSI) until it comes back up, then grab
# the service catalog and notify. Cron-safe: no TCC-protected paths, all
# state under ~/aravalli-prospectivity.
#
# When Bhukosh responds:
#   1. saves the ArcGIS REST service catalog (the layer index needed to
#      script the Rajasthan/Aravalli downloads) to data/bhukosh_services.json
#   2. writes logs/bhukosh_up.flag (presence = already alerted; delete to re-arm)
#   3. fires a macOS notification

BASE="$HOME/aravalli-prospectivity"
LOG="$BASE/logs/bhukosh_watcher.log"
FLAG="$BASE/logs/bhukosh_up.flag"
TS() { date "+%Y-%m-%d %H:%M:%S"; }

[ -f "$FLAG" ] && exit 0   # already caught it; re-arm by deleting the flag

CODE=$(curl -sk -o /dev/null -w "%{http_code}" -m 45 "https://bhukosh.gsi.gov.in/Bhukosh/Public")
echo "$(TS) probe http_code=$CODE" >> "$LOG"

if [ "$CODE" = "200" ] || [ "$CODE" = "302" ]; then
    echo "$(TS) BHUKOSH IS UP" >> "$LOG"
    # capture the ArcGIS REST catalog if exposed (best-effort)
    curl -sk -m 60 "https://bhukosh.gsi.gov.in/arcgis/rest/services?f=json" \
        -o "$BASE/data/bhukosh_services.json" 2>> "$LOG"
    date > "$FLAG"
    /usr/bin/osascript -e 'display notification "Bhukosh (GSI) is back up — Aravalli layer downloads can proceed" with title "Bhukosh watcher"' 2>> "$LOG"
fi
