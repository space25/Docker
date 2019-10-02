# https://github.com/pytorch/pytorch/blob/master/docker/pytorch/Dockerfile
FROM pytorch/pytorch:1.2-cuda10.0-cudnn7-runtime

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONNOUSERSITE="True"

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

RUN apt-get update -y && apt-get install -y \
    locales wget git vim libsm6 libxrender1 && \
    apt-get clean && \
# Set the locale
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*
    
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING=UTF-8

ENV PYTHON_VERSION 3.7
ENV CONDA_ENV_PATH /opt/conda/bin
ENV GPU_CONDA_ENV "gpu_env_py37"
# This is how you will activate this conda environment
ENV CONDA_ACTIVATE_GPU "source ${CONDA_ENV_PATH}/activate ${GPU_CONDA_ENV}"

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

RUN $CONDA_ACTIVATE_GPU && cd /project && ipy_files=$(find * | grep .ipynb$) && jupyter trust $ipy_files

COPY load_dataser.py /

RUN cd / && $CONDA_ACTIVATE_GPU && python load_dataser.py

RUN echo "$CONDA_ACTIVATE_GPU" >> $HOME/.bashrc && \
    echo "alias i_notebook='jupyter notebook --allow-root --notebook-dir=$pwd'" >> $HOME/.bashrc && \
    echo "PS1='\$\w >>> '" >> $HOME/.bashrc

WORKDIR /project