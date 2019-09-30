FROM tensorflow/tensorflow:1.12.0-gpu-py3

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONNOUSERSITE="True"

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    locales wget git vim openssh-server build-essential cmake ninja-build clang g++ gcc automake && \
    apt-get clean && rm -rf /var/lib/apt/lists/* \
# Set the locale
    locale-gen en_US.UTF-8
    
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING=UTF-8

ENV CONDA_ENV_PATH /root/miniconda3/bin
ENV GPU_CONDA_ENV "gpu_env_py36"
ENV PYTHON_VERSION 3.6
# This is how you will activate this conda environment
ENV CONDA_ACTIVATE_GPU "source ${CONDA_ENV_PATH}/activate ${GPU_CONDA_ENV}"
# Install miniconda3
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh

# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $GPU_CONDA_ENV python=${PYTHON_VERSION}

RUN $CONDA_ACTIVATE_GPU && conda info --envs && \
    pip install --upgrade pip && \
    pip install matplotlib pandas scipy scikit-learn \
    jupyter sklearn opencv-python pydot spacy pypng nltk pyyaml && \
    pip install tensorflow-gpu==1.12.0 && \
    conda install pytorch=0.4.1 cuda90 -c pytorch && \
    python -m spacy download en && python -m spacy download en_vectors_web_lg

RUN echo "$CONDA_ACTIVATE_GPU" >> $HOME/.bashrc && \
    echo "alias i_notebook='jupyter notebook --allow-root --notebook-dir=$pwd'" >> $HOME/.bashrc && \
    echo "PS1='\w >>> '" >> $HOME/.bashrc