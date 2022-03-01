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

ENV PYTHON_VERSION 3.8
ENV CONDA_ENV_PATH /home/user/miniconda3/bin


# Install APT packages
RUN apt-get update -y && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:lyzardking/ubuntu-make && \
    add-apt-repository ppa:micahflee/ppa && \
    apt-get update -y && apt-get install -y \
    xauth tar zip git ubuntu-make firefox torbrowser-launcher \
    tmux curl wget mc vim rsync default-jdk \
    g++ gcc gfortran build-essential clang clang-format automake make cmake ninja-build \
    python3 python3-dev python3-pip libjpeg-dev libpng-dev \
    ca-certificates sudo fonts-liberation run-one && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash user
USER user
WORKDIR /home/user

# Install miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh


# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $CONDA_ENV python=${PYTHON_VERSION}

RUN umake ide pycharm /home/user/pycharm

RUN echo "alias pycharm='sh /home/user/pycharm/bin/pycharm.sh'" >> $HOME/.bashrc && \
    echo "PS1='\$\w >>> '" >> $HOME/.bashrc && \
    echo "$CONDA_ACTIVATE" >> $HOME/.bashrc

EXPOSE 8887

WORKDIR /home/user
