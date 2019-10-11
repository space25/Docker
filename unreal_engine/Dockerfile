FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONNOUSERSITE="True"

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

RUN apt-get update -y && apt-get install -y \
    locales wget git unzip vim gedit\
    g++ gcc build-essential cmake ninja-build clang libboost-all-dev \
    libfontconfig1 libfreetype6 libglu1 libsm6 libxcomposite1 libxcursor1 libxi6 libxrandr2 libxrender1 libxss1 libxv1 \
    python3-dev python3-pip python3-numpy \
    x11-xkb-utils xauth xfonts-base  xkb-data && \
    apt-get clean && \
# Set the locale
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*
    
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING=UTF-8

ENV UNAME ue4
ENV UHOME /home/${UNAME}
ENV UID 1001
ENV GID 1001
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

USER $UNAME

RUN mkdir ${UHOME}/unreal
COPY UnrealEngine-release.zip ${UHOME}/unreal

RUN cd ${UHOME}/unreal && unzip UnrealEngine-release.zip && \
    cd UnrealEngine-release && sh Setup.sh && \
    ./GenerateProjectFiles.sh && make && make ARGS=-clean

RUN echo "PS1='\w >>> '" >> $HOME/.bashrc