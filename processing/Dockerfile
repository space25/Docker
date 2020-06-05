FROM ubuntu

ENV L_DOCKER_BUILD_VERSION 1
ENV PYTHON_VERSION 3.7

ENV PYTHONNOUSERSITE="True"
ENV DEBIAN_FRONTEND noninteractive
ENV CONDA_ENV_PATH /root/miniconda3/bin
ENV CONDA_ENV "processing_${PYTHON_VERSION}"

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

# This is how you will activate this conda environment
ENV CONDA_ACTIVATE "source ${CONDA_ENV_PATH}/activate ${CONDA_ENV}"

RUN apt-get update -y && apt-get install -y locales && \
    apt-get clean && \
# Set the locale
    locale-gen en_US.UTF-8
    
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING=UTF-8

# Install APT packages
RUN apt-get install -y \
    apt-utils pkg-config zip unzip git mc nano curl wget snapd\
    x11vnc xvfb \
    default-jre g++ gcc gfortran build-essential protobuf-compiler \
    clang clang-format automake make cmake ninja-build ccache \
    python3-dev python3-pip python3-numpy g++-multilib gcc-multilib\
    zlib1g-dev libboost-all-dev libjpeg-dev libtiff-dev libpng-dev libavcodec-dev \
    # install Node.js 
    # https://github.com/nodesource/distributions/blob/master/README.md
    dirmngr apt-transport-https lsb-release ca-certificates && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get update -y && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh

# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $CONDA_ENV python=${PYTHON_VERSION}

ADD requirements.txt /

RUN $CONDA_ACTIVATE && \
    pip install --upgrade pip && \
    pip --no-cache-dir install -r /requirements.txt  && \
    python -m ipykernel.kernelspec && \
    pip --no-cache-dir install tensorflow-cpu && \
    conda install pytorch torchvision cpuonly -c pytorch

# https://github.com/jupyterlab/debugger
RUN $CONDA_ACTIVATE && \
    conda install -c conda-forge xeus=0.23.14 xeus-python=0.7.1 notebook=6 jupyterlab=2 ptvsd && \
    jupyter labextension install @jupyterlab/debugger

# https://github.com/krassowski/jupyterlab-lsp
RUN $CONDA_ACTIVATE && \
    pip install --no-cache-dir jupyter-lsp && \
    jupyter labextension install @krassowski/jupyterlab-lsp && \
    conda install -c conda-forge python-language-server r-languageserver

# https://github.com/jupyterlab/jupyterlab-git
RUN $CONDA_ACTIVATE && \
    pip install --no-cache-dir jupyterlab-git && \
    jupyter labextension install @jupyterlab/git

RUN echo "alias i_jupyter='jupyter lab --allow-root --notebook-dir=$pwd --no-browser --ip=0.0.0.0'" >> $HOME/.bashrc && \
    echo "PS1='\$\w >>> '" >> $HOME/.bashrc && \
    echo "$CONDA_ACTIVATE" >> $HOME/.bashrc

WORKDIR /