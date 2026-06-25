#!/bin/bash
tail -F /var/log/suricata/eve.json | while read line; do
  EVENT=$(echo "$line" | jq -r '.event_type')
  if [ "$EVENT" = "alert" ]; then
    SRC=$(echo "$line" | jq -r '.src_ip')
    echo "Blocking $SRC"
    iptables -A INPUT -s "$SRC" -j DROP
  fi
done
