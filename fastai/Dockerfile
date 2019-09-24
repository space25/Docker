FROM ubuntu:18.04

ENV PYTHON_VERSION 3.7

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONNOUSERSITE="True"
ENV CONDA_ENV_PATH /root/miniconda3/bin
ENV GPU_CONDA_ENV "gpu_env_py37"

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

# This is how you will activate this conda environment
ENV CONDA_ACTIVATE_GPU "source ${CONDA_ENV_PATH}/activate ${GPU_CONDA_ENV}"

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh && \
    apt-get update -y && apt-get install -y --no-install-recommends \
    locales wget git && \
    apt-get clean && \
# Set the locale
    locale-gen en_US.UTF-8
    
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING=UTF-8

# Install miniconda3
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $GPU_CONDA_ENV python=${PYTHON_VERSION}

RUN mkdir /project && cd /project && git clone https://github.com/fastai/course-v3

RUN $CONDA_ACTIVATE_GPU && conda info --envs && \
    pip install --upgrade pip && \
    conda install matplotlib numpy pandas scipy scikit-learn jupyter && \
    pip install sklearn opencv-python fire && \
    conda install pytorch torchvision cudatoolkit=10.0 -c pytorch && \
    conda install -c fastai fastai && \
    python -m ipykernel.kernelspec

RUN echo "$CONDA_ACTIVATE_GPU" >> $HOME/.bashrc