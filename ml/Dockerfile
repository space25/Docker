FROM tensorflow/tensorflow:1.12.0-gpu-py3

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONIOENCODING=UTF-8
ENV PYTHONNOUSERSITE="True"
ENV CONDA_ENV_PATH /root/miniconda3/bin
ENV GPU_CONDA_ENV "gpu_env_py36"
ENV CPU_CONDA_ENV "cpu_env_py36"
ENV PYTHON_VERSION 3.6
ENV OPEN_CV_VERSION 4.1.0
ENV TENSORFLOW_VERSION 1.12.2
ENV CMAKE_VERSION 3.14.3

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

# Install miniconda3
RUN apt-get update -y && apt-get install -y --no-install-recommends wget bzip2 locales && \
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the locale
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $GPU_CONDA_ENV python=${PYTHON_VERSION} && \
    ${CONDA_ENV_PATH}/conda create -n $CPU_CONDA_ENV python=${PYTHON_VERSION}

# This is how you will activate this conda environment
ENV CONDA_ACTIVATE_GPU "source ${CONDA_ENV_PATH}/activate ${GPU_CONDA_ENV}"
ENV CONDA_ACTIVATE_CPU "source ${CONDA_ENV_PATH}/activate ${CPU_CONDA_ENV}"

RUN add-apt-repository ppa:ubuntu-toolchain-r/test

# Install APT packages
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    apt-utils \
    software-properties-common \
    protobuf-compiler \
    pkg-config \
    curl \
    build-essential \
    ninja-build \
    rsync \
    unzip \
    cmake \
    git \
    gfortran \
    nano \
    vim \
    libboost-all-dev \
    libopenimageio-dev \
    libfreetype6-dev \
    libpng12-dev \
    libzmq3-dev \
    libjpeg-dev \
    libtiff-dev \
    libjasper-dev \
    libpng-dev \
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libgtk2.0-dev \
    libatlas-base-dev \
    libtbb2 \
    libtbb-dev \
    libdc1394-22-dev \
    libxvidcore-dev \
    libx264-dev \
    libgtk-3-dev \
    libffi6 \
    libffi-dev \
    libopencv-dev \
    swig \
    graphviz \
    libgtest-dev \
    doxygen \
    clang \
    qtdeclarative5-dev \
    gcc-8 \
    g++-8 \
    tesseract-ocr-all \
    ccache \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-fonts-recommended \
    libboost-all-dev \
    netcdf-bin \
    libnetcdf-dev \
    libtool-bin automake \
    nvidia-current \
    htop \
    tmux \
    xvfb && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 90 --slave /usr/bin/g++ g++ /usr/bin/g++-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

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

# Build cmake
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz &&\
    tar -xzvf cmake-${CMAKE_VERSION}.tar.gz &&\
    cd cmake-${CMAKE_VERSION} &&\
    ./bootstrap &&\
    make &&\
    make install &&\
    cd .. &&\
    rm -rf cmake-${CMAKE_VERSION}

COPY requirements.txt /

# Install python packages
RUN $CONDA_ACTIVATE_GPU && conda info --envs && \
    pip install --upgrade pip && \
    pip --no-cache-dir install -r /requirements.txt  && \
    python -m ipykernel.kernelspec

RUN $CONDA_ACTIVATE_CPU && conda info --envs && \
    pip install --upgrade pip && \
    pip --no-cache-dir install -r /requirements.txt && \
    python -m ipykernel.kernelspec

# Install tensorflow pip package
RUN $CONDA_ACTIVATE_GPU && pip --no-cache-dir install tensorflow-gpu==${TENSORFLOW_VERSION}
RUN $CONDA_ACTIVATE_CPU && pip --no-cache-dir install tensorflow==${TENSORFLOW_VERSION}

RUN echo "$CONDA_ACTIVATE_GPU" >> $HOME/.bashrc && \
    # Run fake X server. It needs for using QT
    echo "pgrep -x Xvfb > /dev/null || Xvfb :0 & export DISPLAY=:0 " >> $HOME/.bashrc && \
    echo "set -g mouse on" >> $HOME/.tmux.conf && \
    echo "set-option -g history-limit 100000" >> $HOME/.tmux.conf

WORKDIR "/"