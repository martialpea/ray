#!/bin/bash
tmux kill-session -t g2ray 2>/dev/null || true
tmux new-session -d -s g2ray
tmux send-keys -t g2ray "sudo /usr/local/bin/xray run -c /etc/xray/g2ray.json &>/tmp/xray.log" Enter
sleep 2
show-link.sh
echo "[g2ray] سرور داخل tmux اجرا شد — ترمینال را می‌توانید ببندید"
echo "[g2ray] برای دیدن log: tmux attach -t g2ray"