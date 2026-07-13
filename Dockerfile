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

CMD ["ttyd", "-p", "7860", "-w", "bash", "-c", "screen -ls | grep -q session || screen -dmS session bash -l; screen -r session"]
