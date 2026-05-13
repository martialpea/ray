#!/bin/bash
CONFIG="/etc/xray/g2ray.json"
UUID=$(grep -o '"id": *"[^"]*"' "$CONFIG" | head -1 | grep -o '"[^"]*"$' | tr -d '"')
if [ -z "$UUID" ]; then echo "[g2ray] UUID پیدا نشد."; exit 1; fi
SNI="${CODESPACE_NAME}-443.app.github.dev"
LINK="vless://${UUID}@94.130.50.12:443?encryption=none&security=tls&sni=${SNI}&host=${SNI}&fp=chrome&allowInsecure=1&type=xhttp&mode=packet-up&path=%2F#storm-relay-533f67"

echo ""
echo "================================================"
echo "  $LINK"
echo "================================================"
echo ""

if [ -n "$TELEGRAM_BOT_TOKEN" ] && [ -n "$TELEGRAM_CHAT_ID" ]; then
    # بررسی می‌کنیم که آیا قبلاً پیام تلگرام در این بار روشن شدن سرور ارسال شده یا نه
    if [ ! -f "/tmp/tg_sent" ]; then
        SAFE_LINK="${LINK//&/%26}"
        MESSAGE="✅ <b>سرور Codespace روشن شد!</b>%0A%0A🌐 <b>نام سرور:</b> <code>${CODESPACE_NAME}</code>%0A%0A🔗 <b>لینک اتصال VLESS:</b>%0A<code>${SAFE_LINK}</code>"
        
        # ارسال پیام به تلگرام در پس‌زمینه
        curl -s -X POST "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
            -d chat_id="${TELEGRAM_CHAT_ID}" \
            -d text="$MESSAGE" \
            -d parse_mode="HTML" > /dev/null &
            
        # ساخت فایل قفل تا پیام دیگر تکرار نشود
        touch /tmp/tg_sent
    fi
fi
