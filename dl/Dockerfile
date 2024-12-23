FROM ubuntu

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONIOENCODING=UTF-8

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get autoremove && \
    apt-get install -y python3 python3-dev python3-pip \
                        ffmpeg locales rtorrent nano mc wget && \
                        apt-get clean && rm -rf /var/lib/apt/lists/* && \
                        locale-gen en_US.UTF-8

# Set the locale
ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8

ENV PYTHON_VERSION=3.11
ENV CONDA_ENV_PATH=/root/miniconda3/bin
ENV CONDA_ENV="env_cpu_${PYTHON_VERSION}"


# Install miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh

# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $CONDA_ENV python=${PYTHON_VERSION}

# This is how you will activate this conda environment
ENV CONDA_ACTIVATE="source ${CONDA_ENV_PATH}/activate ${CONDA_ENV}"

RUN $CONDA_ACTIVATE && \
    pip install --upgrade pip && \
    pip --no-cache-dir install yt-dlp

RUN echo "PS1='\$\w >>> '" >> $HOME/.bashrc && \
    echo "$CONDA_ACTIVATE" >> $HOME/.bashrc

WORKDIR /data
