FROM tensorflow/tensorflow:1.12.0-devel-gpu-py3
ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONIOENCODING=UTF-8

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh

# Install miniconda3
RUN apt-get update -y && apt-get install -y --no-install-recommends wget bzip2 && \
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PYTHONNOUSERSITE="True"
ENV CONDA_ENV_PATH /root/miniconda3/bin
ENV CONDA_ENV "python36"

# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $CONDA_ENV python=3.6

# This is how you will activate this conda environment
ENV CONDA_ACTIVATE "source ${CONDA_ENV_PATH}/activate ${CONDA_ENV}"

RUN add-apt-repository ppa:ubuntu-toolchain-r/test

# Install APT packages
RUN $CONDA_ACTIVATE &&  apt-get update -y && apt-get install -y --no-install-recommends \
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

RUN mkdir /cv && cd /cv &&\
    git clone --depth 1 https://github.com/opencv/opencv_contrib.git -b 4.0.1 &&\
    git clone --depth 1 https://github.com/opencv/opencv.git -b 4.0.1 &&\
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

RUN wget https://github.com/Kitware/CMake/releases/download/v3.10.2/cmake-3.10.2.tar.gz &&\
    tar -xzvf cmake-3.10.2.tar.gz &&\
    cd cmake-3.10.2 &&\
    ./bootstrap &&\
    make &&\
    make install &&\
    cd .. &&\
    rm -rf cmake-3.10.2

# Install python packages
RUN $CONDA_ACTIVATE && conda info --envs && \
    pip install --upgrade pip && \
    pip --no-cache-dir install setuptools Pillow h5py hdf5storage ipykernel jupyter matplotlib numpy \
    pandas scipy sklearn scikit-learn scikit-image csvkit cloudpickle pickleshare numexpr \
    CFFI tqdm lxml editdistance cairocffi pyqt5 qimage2ndarray dotmap pandas json5 pydotplus \
    scikit_learn Augmentor opencv-python torch torchvision shapely[vectorized] pyclipper \
    albumentations imagesize numba python-levenshtein jamo Deprecated && \
    python -m ipykernel.kernelspec

# Install pip packages
RUN $CONDA_ACTIVATE && pip --no-cache-dir install --upgrade tensorflow-gpu==1.12.0

RUN echo "$CONDA_ACTIVATE" >> $HOME/.bashrc && \
    # Run fake X server. It needs for using QT
    echo "pgrep -x Xvfb > /dev/null || Xvfb :0 & export DISPLAY=:0 " >> $HOME/.bashrc && \
    echo "set -g mouse on" >> $HOME/.tmux.conf && \
    echo "set-option -g history-limit 100000" >> $HOME/.tmux.conf

WORKDIR "/"