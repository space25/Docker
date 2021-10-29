FROM ubuntu

LABEL maintainer="Valera <https://github.com/space25/>"

ENV PYTHONNOUSERSITE="True"
ENV DEBIAN_FRONTEND noninteractive

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

RUN apt-get update -y && apt-get install -y locales && \
    apt-get clean && \
# Set the locale
    locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING=UTF-8


# Install APT packages
RUN apt-get update -y && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:lyzardking/ubuntu-make && \
    apt-get update -y && apt-get install -y \
    xauth tar zip git ubuntu-make firefox \
    tmux curl wget mc vim rsync default-jdk \
    g++ gcc gfortran build-essential clang clang-format automake make cmake ninja-build \
    python3 python3-dev python3-pip libjpeg-dev libpng-dev \
    ca-certificates sudo fonts-liberation run-one && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN umake ide pycharm-professional /root/pycharm

RUN echo "alias pycharm='sh /root/pycharm/bin/pycharm.sh'" >> $HOME/.bashrc

EXPOSE 8887

WORKDIR /root