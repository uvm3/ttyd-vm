FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    wget \
    && rm -rf /var/lib/apt/lists/*

RUN wget -O ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.4/ttyd.x86_64 \
    && chmod +x ttyd \
    && mv ttyd /usr/local/bin/

RUN echo 'root:root' | chpasswd
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER root

EXPOSE 7860

CMD ["ttyd", "-p", "7860", "-W", "bash"]
