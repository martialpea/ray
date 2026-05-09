#!/bin/bash
# show-link.sh - نمایش لینک اتصال با UUID و hostname صحیح

CONFIG="/etc/xray/g2ray.json"

# استخراج UUID از config
UUID=$(python3 -c "import json; c=json.load(open('$CONFIG')); print(c['inbounds'][0]['settings']['clients'][0]['id'])" 2>/dev/null)

if [ -z "$UUID" ]; then
  echo "[g2ray] خطا: UUID پیدا نشد."
  exit 1
fi

# ساخت hostname پویا از متغیر محیطی Codespace
HOST="${CODESPACE_NAME}-443.app.github.dev"

LINK="vless://${UUID}@${HOST}:443?encryption=none&security=tls&sni=${HOST}&type=xhttp&mode=packet-up&path=%2F#g2ray-${CODESPACE_NAME}"

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║              g2ray - لینک اتصال شما                 ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""
echo "$LINK"
echo ""
echo "─────────────────────────────────────────────────────"
echo "راهنما:"
echo "  • این لینک را در v2rayNG، Nekobox یا هر کلاینت سازگار وارد کنید"
echo "  • Codespace را بعد از استفاده متوقف کنید (صرفه‌جویی در quota)"
echo "  • هر بار Codespace را باز کنید، لینک جدید نمایش داده می‌شود"
echo "─────────────────────────────────────────────────────"
echo ""
