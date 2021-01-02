FROM ubuntu
# FROM tensorflow/tensorflow:2.4.0-gpu

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

ENV L_DOCKER_BUILD_VERSION 1
ENV PYTHON_VERSION 3.8
ENV OPEN_CV_VERSION 4.5.1

ENV PYTHONNOUSERSITE="True"
ENV DEBIAN_FRONTEND noninteractive
ENV CONDA_ENV_PATH /root/miniconda3/bin
ENV CONDA_ENV "env_cpu_${PYTHON_VERSION}"

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
RUN apt-get update -y && apt-get install -y \
    htop openssh-server tmux vim neovim ca-certificates \
    apt-utils pkg-config zip unzip git mc nano curl wget \
    x11vnc xvfb \
    default-jre g++ gcc gfortran build-essential protobuf-compiler\
    clang clang-format automake make cmake ninja-build ccache \
    python3-dev python3-pip python3-numpy g++-multilib gcc-multilib \
    zlib1g zlib1g-dev libboost-all-dev libjpeg-dev libtiff-dev libpng-dev libavcodec-dev ffmpeg \
    libavformat-dev libswscale-dev libv4l-dev libtbb2 libtbb-dev libdc1394-22-dev \
    libxvidcore-dev libx264-dev netcdf-bin\
    libnetcdf-dev libtool-bin automake ccache\
    qtcreator clang-format default-jdk \
    nodejs npm && \
    apt-get install -y libglu1-mesa-dev libgl1-mesa-dev libosmesa6-dev patchelf libglfw3 \
    libglfw3-dev swig && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh

# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $CONDA_ENV python=${PYTHON_VERSION}

# # Build OpenCV
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


RUN $CONDA_ACTIVATE && \
    pip install --upgrade pip && \
    conda install -c conda-forge jupyterlab && \
    conda install -y scipy numpy matplotlib tqdm && \
    conda install -c conda-forge opencv && \
    conda install pytorch torchvision torchaudio cpuonly -c pytorch && \
    pip --no-cache-dir install tensorflow-cpu


RUN $CONDA_ACTIVATE && \
    conda install -c conda-forge gym && \
    conda install -c conda-forge box2d-py && \
    conda install -c conda-forge atari_py

RUN git clone https://github.com/VundleVim/Vundle.vim.git /root/.vim/bundle/Vundle.vim

ADD .vimrc /root/

RUN mkdir /root/PROJECTS

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN echo "alias i_jupyter_lab='jupyter lab --allow-root --notebook-dir=$pwd --no-browser --ip=0.0.0.0'" >> $HOME/.bashrc && \
    echo "alias i_jupyter_notebook='jupyter notebook --allow-root --notebook-dir=$pwd --no-browser --ip=0.0.0.0'" >> $HOME/.bashrc && \
    echo "PS1='\$\w >>> '" >> $HOME/.bashrc && \
    echo "$CONDA_ACTIVATE" >> $HOME/.bashrc

WORKDIR /
