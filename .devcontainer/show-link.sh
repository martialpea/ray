#!/bin/bash
CONFIG="/etc/xray/g2ray.json"
UUID=$(grep -o '"id": *"[^"]*"' "$CONFIG" | head -1 | grep -o '"[^"]*"$' | tr -d '"')
if [ -z "$UUID" ]; then echo "[g2ray] UUID پیدا نشد."; exit 1; fi
SNI="${CODESPACE_NAME}-443.app.github.dev"
LINK="vless://${UUID}@94.130.50.12:443?encryption=none&security=tls&sni=${SNI}&host=${SNI}&fp=chrome&allowInsecure=1&type=xhttp&mode=packet-up&path=%2F#storm-relay-533f67"

if [ ! -f "/tmp/link_sent" ]; then
    # حذف فاصله‌های اضافی برای نمایش صحیح در بله
    MESSAGE="✅ <b>سرور Codespace روشن شد!</b>

🌐 <b>نام سرور:</b>
<code>${CODESPACE_NAME}</code>

🔗 <b>لینک اتصال VLESS:</b>
<code>${LINK}</code>"
    
    # ارسال به بله با استفاده از --data-urlencode برای جلوگیری از خرابی متن
    if [ -n "$BALE_BOT_TOKEN" ] && [ -n "$BALE_CHAT_ID" ]; then
        curl -s -X POST "https://tapi.bale.ai/bot${BALE_BOT_TOKEN}/sendMessage" \
            --data-urlencode "chat_id=${BALE_CHAT_ID}" \
            --data-urlencode "text=$MESSAGE" \
            -d "parse_mode=HTML" > /dev/null &
    fi
    
    # ارسال به تلگرام (اگر همچنان فعال است)
    if [ -n "$TG_BOT_TOKEN" ] && [ -n "$TG_CHAT_ID" ]; then
        curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
            --data-urlencode "chat_id=${TG_CHAT_ID}" \
            --data-urlencode "text=$MESSAGE" \
            -d "parse_mode=HTML" > /dev/null &
    fi
    
    touch /tmp/link_sent
fi
