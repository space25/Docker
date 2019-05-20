FROM nextcloud:apache

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends python3 python3-dev python3-pip locales wget unzip nano \
    ffmpeg libmagickcore-6.q16-3-extra smbclient supervisor libreoffice \
    libbz2-dev libc-client-dev libgmp3-dev libkrb5-dev

# RUN apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false

ENV NEXTCLOUD_ADMIN_USER=auser
ENV NEXTCLOUD_ADMIN_PASSWORD=123456qazwsx
ENV NEXTCLOUD_UPDATE=1

CMD ["/usr/bin/supervisord"]
