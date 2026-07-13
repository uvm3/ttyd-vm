FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    wget \
    screen \
    bash \ 
    && rm -rf /var/lib/apt/lists/*

RUN wget -O ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 \
    && chmod +x ttyd \
    && mv ttyd /usr/local/bin/

RUN echo 'root:root' | chpasswd
RUN echo "root ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN usermod -s /bin/bash root

USER root
EXPOSE 7860

CMD ["ttyd", "-p", "7860", "-W", "screen", "-R", "session", "bash", "-l"]
