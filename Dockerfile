FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    git \
    rclone \
    screen \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate -O /usr/local/bin/ttyd \
    https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 \
    && chmod +x /usr/local/bin/ttyd

RUN echo 'root:root' | chpasswd && usermod -s /bin/bash root

EXPOSE 7860

CMD ["ttyd", "-p", "7860", "-W", "bash", "-c", "screen -wipe; SESSION=$(screen -ls | grep -oP '\\d+\\.\\S+' | head -1 | cut -d. -f1); if [ -n \"$SESSION\" ]; then screen -r $SESSION; else screen -dmS $(date +%s) bash -l && exec screen -r; fi || bash -l"]
