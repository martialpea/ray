#!/bin/bash
CONFIG="/etc/xray/g2ray.json"
UUID=$(grep -o '"id": *"[^"]*"' "$CONFIG" | head -1 | grep -o '"[^"]*"$' | tr -d '"')
[ -z "$UUID" ] && exit 1

SNI="${CODESPACE_NAME}-443.app.github.dev"
LINK="vless://${UUID}@94.130.50.12:443?encryption=none&security=tls&sni=${SNI}&host=${SNI}&fp=chrome&allowInsecure=1&type=xhttp&mode=packet-up&path=%2F#storm-relay-533f67"

# چاپ در ترمینال (بدون شرط)
echo -e "\n================================================\n${LINK}\n================================================\n"

# ارسال پیام (فقط یکبار در هر بوت)
if [ ! -f "/tmp/link_sent" ]; then
    # پیام ساده بدون تگ های پیچیده برای پایداری در بله و تلگرام
    MESSAGE="✅ Server Online!
    
Name: ${CODESPACE_NAME}
Link: ${LINK}"

    # ارسال به تلگرام
    if [ -n "${TG_BOT_TOKEN:-}" ] && [ -n "${TG_CHAT_ID:-}" ]; then
        curl -s -X POST "https://api.telegram.org/bot${TG_BOT_TOKEN}/sendMessage" \
            --data-urlencode "chat_id=${TG_CHAT_ID}" \
            --data-urlencode "text=${MESSAGE}" > /dev/null &
    fi

    # ارسال به بله
    if [ -n "${BALE_BOT_TOKEN:-}" ] && [ -n "${BALE_CHAT_ID:-}" ]; then
        curl -s -X POST "https://tapi.bale.ai/bot${BALE_BOT_TOKEN}/sendMessage" \
            --data-urlencode "chat_id=${BALE_CHAT_ID}" \
            --data-urlencode "text=${MESSAGE}" > /dev/null &
    fi
    touch /tmp/link_sent
fi
