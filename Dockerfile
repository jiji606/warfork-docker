FROM debian:buster-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    lib32gcc1=1:8.3.0-6 \
    lib32stdc++6=8.3.0-6 \
    wget=1.20.1-1.1 \
    ca-certificates=20190110 \
    rsync=3.1.3-6 \
    unzip=6.0-23+deb10u1 \
    tmux \
    jq \
    bc \
    binutils \
    ca-certificates \
    util-linux \
    python \
    curl \
    wget \
    file \
    tar \
    bzip2 \
    gzip \
    unzip \
    bsdmainutils \
    libcurl4 \
    libcurl3-gnutls \
    libcurl4-gnutls-dev \
    wait-for-it \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -d /var/warfork -r -m warfork

USER warfork
RUN mkdir /var/warfork/Steam ; mkdir /var/warfork/server
WORKDIR /var/warfork/Steam
RUN wget -qO- https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz | tar zxf -
RUN /var/warfork/Steam/steamcmd.sh +quit
RUN /var/warfork/Steam/steamcmd.sh \
    +login anonymous \
    +force_install_dir /var/warfork/server \
    +app_update 1136510 validate \
    +quit

WORKDIR /var/warfork
COPY entrypoint.sh /usr/local/bin/
COPY entrypointtv.sh /usr/local/bin/

WORKDIR /var/warfork/server/Warfork.app/Contents/Resources
CMD [ "bash", "/usr/local/bin/entrypoint.sh" ]
