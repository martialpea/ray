FROM debian:bookworm-slim

ENV XRAY_VERSION=v26.3.27

COPY setup.sh /tmp/setup.sh
COPY config.json /etc/xray/g2ray.json

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       bash curl wget unzip ca-certificates openssl uuid-runtime \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x /tmp/setup.sh \
    && /tmp/setup.sh \
    && rm /tmp/setup.sh

# Generate UUID at build time as default (overridden at runtime)
RUN UUID=$(uuidgen) && \
    sed -i "s|\${XRAY_UUID}|$UUID|g" /etc/xray/g2ray.json

EXPOSE 443

CMD ["/usr/local/bin/xray", "run", "-c", "/etc/xray/g2ray.json"]
