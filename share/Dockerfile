FROM ubuntu

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONIOENCODING=UTF-8

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get autoremove && \
    apt-get install -y nano mc openssh-server locales mc &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the locale
RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

WORKDIR /data

# CMD ["/usr/sbin/sshd", "-D"]
