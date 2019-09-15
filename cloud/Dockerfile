FROM nextcloud:17.0.0RC1-apache

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
    python3 python3-dev python3-pip locales wget unzip nano \
    ffmpeg libmagickcore-6.q16-3-extra smbclient supervisor \
    libbz2-dev libc-client-dev libgmp3-dev libkrb5-dev

ADD 000-default.conf /etc/apache2/sites-available

RUN mkdir /etc/apache2/ssl && a2enmod rewrite headers env dir mime setenvif ssl

ENV NEXTCLOUD_UPDATE=1
