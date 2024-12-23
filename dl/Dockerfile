FROM ubuntu

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONIOENCODING=UTF-8

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get autoremove && \
    apt-get install -y python3 python3-dev python3-pip \
                        ffmpeg locales rtorrent mc && \
                        apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the locale
RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8

RUN python3 -m pip config set global.break-system-packages true
RUN pip3 --no-cache-dir install yt-dlp

WORKDIR /data
