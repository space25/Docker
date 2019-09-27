FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONNOUSERSITE="True"

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

RUN apt-get update -y && apt-get install -y \
    locales wget git unzip vim gedit\
    g++ gcc build-essential cmake ninja-build clang libboost-all-dev && \
    apt-get clean && \
# Set the locale
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*
    
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING=UTF-8

RUN mkdir /unreal

ADD UnrealEngine-release.zip /unreal

RUN cd /unreal && unzip UnrealEngine-release.zip && \
    cd UnrealEngine-release && sh Setup.sh

RUN echo "PS1='\$\w >>> '" >> $HOME/.bashrc

WORKDIR /