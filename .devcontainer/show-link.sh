#!/bin/bash
CONFIG="/etc/xray/g2ray.json"
UUID=$(grep -o '"id": *"[^"]*"' "$CONFIG" | head -1 | grep -o '"[^"]*"$' | tr -d '"')
if [ -z "$UUID" ]; then echo "[g2ray] UUID پیدا نشد."; exit 1; fi
HOST="94.130.50.12"
LINK="vless://${UUID}@${HOST}:443?encryption=none&security=none&type=xhttp&mode=packet-up&path=%2F#fast-tunnel-7f0f0a"
echo ""
echo "================================================"
echo "  $LINK"
echo "================================================"
echo ""