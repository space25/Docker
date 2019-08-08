FROM tensorflow/tensorflow:1.14.0-gpu-py3

ENV PYTHON_VERSION 3.7
ENV OPEN_CV_VERSION 4.1.0
ENV TENSORFLOW_VERSION 1.14.0
ENV CMAKE_VERSION 3.14.3

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONNOUSERSITE="True"
ENV CONDA_ENV_PATH /root/miniconda3/bin
ENV GPU_CONDA_ENV "gpu_env_py37"
ENV CPU_CONDA_ENV "cpu_env_py37"
ENV BETA1_CONDA_ENV "beta1_env_py37"

# This is how you will activate this conda environment
ENV CONDA_ACTIVATE_GPU "source ${CONDA_ENV_PATH}/activate ${GPU_CONDA_ENV}"
ENV CONDA_ACTIVATE_CPU "source ${CONDA_ENV_PATH}/activate ${CPU_CONDA_ENV}"
ENV CONDA_ACTIVATE_BETA1 "source ${CONDA_ENV_PATH}/activate ${BETA1_CONDA_ENV}"

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh && \
    apt-get update -y && apt-get install -y --no-install-recommends \
    locales && \
    apt-get clean && \
# Set the locale
    locale-gen en_US.UTF-8
    
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING=UTF-8

# Install APT packages
RUN apt-get install -y --no-install-recommends \
    pkg-config apt-utils zip g++ zlib1g-dev unzip \
    openjdk-8-jdk automake  gfortran \
    build-essential cmake ninja-build git clang clang-format \
    protobuf-compiler pkg-config \
    python3-dev python3-pip python3-numpy \
    python-dev python-numpy \
    ccache qtcreator qtdeclarative5-dev libboost-all-dev \
    libjpeg-dev libtiff-dev libpng-dev libavcodec-dev \
    libavformat-dev libswscale-dev libv4l-dev \
    libgtk2.0-dev libatlas-base-dev libtbb2 libtbb-dev \
    libdc1394-22-dev libxvidcore-dev libx264-dev \
    libgtk-3-dev swig graphviz libgtest-dev \
    doxygen texlive-latex-base texlive-latex-extra texlive-fonts-recommended \
    g++-multilib netcdf-bin libnetcdf-dev \
    gcc-multilib texlive-latex-base vim nano \
    texlive-fonts-recommended netcdf-bin \
    libnetcdf-dev libtool-bin tmux xvfb htop rsync wget bzip2 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install miniconda3
RUN wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $GPU_CONDA_ENV python=${PYTHON_VERSION} && \
    ${CONDA_ENV_PATH}/conda create -n $CPU_CONDA_ENV python=${PYTHON_VERSION} && \
    ${CONDA_ENV_PATH}/conda create -n $BETA1_CONDA_ENV python=${PYTHON_VERSION}

# Build OpenCV
RUN mkdir /cv && cd /cv &&\
    git clone --depth 1 https://github.com/opencv/opencv_contrib.git -b ${OPEN_CV_VERSION} &&\
    git clone --depth 1 https://github.com/opencv/opencv.git -b ${OPEN_CV_VERSION} &&\
    cd opencv &&\
    mkdir build &&\
    cd build &&\
    cmake -G "Ninja"\
    -D CMAKE_BUILD_TYPE=RELEASE\
    -D CMAKE_INSTALL_PREFIX=/usr/local\
    -D INSTALL_C_EXAMPLES=OFF\
    -D INSTALL_PYTHON_EXAMPLES=OFF\
    -D OPENCV_EXTRA_MODULES_PATH=/cv/opencv_contrib/modules\
    -D BUILD_opencv_legacy=OFF\
    -D BUILD_EXAMPLES=OFF\
    -D WITH_CUDA=OFF\
    -D ENABLE_AVX=ON\
    -D WITH_OPENGL=ON\
    -D WITH_TIFF=ON\
    -D BUILD_TIFF=ON .. &&\
    ninja && ninja install && ldconfig && rm -rf /cv

ADD requirements.txt /

# Install python packages
# GPU
RUN $CONDA_ACTIVATE_GPU && conda info --envs && \
    pip install --upgrade pip && \
    pip --no-cache-dir install -r /requirements.txt  && \
    python -m ipykernel.kernelspec && \
# CPU   
    $CONDA_ACTIVATE_CPU && conda info --envs && \
    pip install --upgrade pip && \
    pip --no-cache-dir install -r /requirements.txt && \
    python -m ipykernel.kernelspec && \
# GPU nightly
    $CONDA_ACTIVATE_BETA1 && conda info --envs && \
    pip install --upgrade pip && \
    pip --no-cache-dir install -r /requirements.txt && \
    python -m ipykernel.kernelspec && \
# Install tensorflow pip package
    $CONDA_ACTIVATE_GPU && pip --no-cache-dir install tensorflow-gpu==${TENSORFLOW_VERSION} && \
    $CONDA_ACTIVATE_CPU && pip --no-cache-dir install tensorflow==${TENSORFLOW_VERSION} && \
    $CONDA_ACTIVATE_BETA1 && pip --no-cache-dir install tensorflow-gpu==2.0.0-beta1

RUN echo "$CONDA_ACTIVATE_GPU" >> $HOME/.bashrc

WORKDIR "/"