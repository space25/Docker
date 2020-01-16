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

RUN apt-get update -y && apt-get install -y --no-install-recommends locales && \
    apt-get clean && \
# Set the locale
    locale-gen en_US.UTF-8
    
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING=UTF-8

# Install APT packages
RUN apt-get install -y --no-install-recommends \
    mc nano rsync wget curl bzip2 nodejs npm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install miniconda3
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh

# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $CONDA_ENV python=${PYTHON_VERSION}

# Install python packages
RUN $CONDA_ACTIVATE && conda info --envs &&\
    pip --no-cache-dir install pandas matplotlib tensorflow-cpu && \
    conda install jupyterlab pytorch torchvision cpuonly -c pytorch 

RUN echo "alias i_jupyter='jupyter lab --allow-root --notebook-dir=$pwd --no-browser --ip=0.0.0.0 --certfile=/ssl_jupyter/jupyter_cert.pem --keyfile /ssl_jupyter/jupyter_key.key'" >> $HOME/.bashrc && \
    echo "PS1='\$\w >>> '" >> $HOME/.bashrc && \
    echo "$CONDA_ACTIVATE" >> $HOME/.bashrc

WORKDIR /