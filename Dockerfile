FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    bash \
    curl \
    screen \
    sudo \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 \
    && chmod +x /usr/local/bin/ttyd

RUN echo 'root:root' | chpasswd \
    && echo "root ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && usermod -s /bin/bash root

USER root
EXPOSE 7860

CMD ["ttyd", "-p", "7860", "-W", "-T", "screen", "-R", "session", "bash", "-l"]
