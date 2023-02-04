FROM ubuntu:22.04

LABEL maintainer="Valera <https://github.com/space25/>"


ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONNOUSERSITE="True"
ENV PYTHON_VERSION 3.10
ENV OPENCV_VERSION 4.6.0
ENV USER_NAME vm

ENV CONDA_ENV_PATH /home/${USER_NAME}/miniconda3/bin

# Change sh to bash
RUN ln -sf /bin/bash /bin/sh


# Install APT packages
RUN apt-get update -y && \
    apt-get install -y \
    locales && \
    # Set the locale
    locale-gen en_US.UTF-8 && \
    # Install Brave browser
    apt-get install -y apt-transport-https curl && \
    curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"| tee /etc/apt/sources.list.d/brave-browser-release.list && \
    apt update -y && \
    apt-get install -y brave-browser && \
    #Install libs
    apt-get install -y \
    procps file xauth tar zip meld openssh-server \
    tmux wget mc vim rsync git meld filezilla meld nautilus terminator \
    build-essential cmake make default-jdk clang clang-format automake ninja-build g++ gcc gfortran libboost-all-dev \
    swig libjsoncpp-dev libgtk2.0-dev pkg-config libjpeg-dev libtiff-dev libpng-dev libavcodec-dev \
    python3 python3-dev python3-pip python3-numpy \
    ca-certificates sudo fonts-liberation && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV PYTHONIOENCODING=UTF-8

RUN mkdir opencv && cd opencv && \
    wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip && \
    unzip ${OPENCV_VERSION}.zip && cd opencv-${OPENCV_VERSION} && mkdir build && cd build && \
    cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr/local \
    -DINSTALL_C_EXAMPLES=OFF \
    -DINSTALL_PYTHON_EXAMPLES=OFF \
    -DOPENCV_GENERATE_PKGCONFIG=ON \
    -DBUILD_opencv_xfeatures2d=OFF \
    -DWITH_CUDA=OFF \
    -DBUILD_opencv_gpu=OFF \
    -DBUILD_DOCS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DBUILD_TESTS=OFF \
    -DBUILD_opencv_apps=OFF \
    -DBUILD_EXAMPLES=OFF \
    -DWITH_OPENGL=ON \
    -DWITH_TIFF=ON \
    -DBUILD_TIFF=ON \
    -DBUILD_opencv_legacy=OFF \
    .. && \
    make -j 10 && make install


# ENV DISPLAY=host.docker.internal:0.0

RUN sed -i 's/#*X11Forwarding.*/X11Forwarding yes/' /etc/ssh/sshd_config
RUN sed -i 's/#*X11UseLocalhost.*/X11UseLocalhost no/' /etc/ssh/sshd_config
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN useradd -m ${USER_NAME} -p $(openssl passwd <set_password!!!>)
USER ${USER_NAME}
EXPOSE 22

RUN cd /home/${USER_NAME} && mkdir TOOLS
# Install miniconda3
RUN cd /home/${USER_NAME}/TOOLS && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    chmod +x Miniconda3-latest-Linux-x86_64.sh && \
    ./Miniconda3-latest-Linux-x86_64.sh -b && \
    rm -f ./Miniconda3-latest-Linux-x86_64.sh

ENV CONDA_ENV "dev_${PYTHON_VERSION}"
# Create virtualenv
RUN ${CONDA_ENV_PATH}/conda update -n base conda && \
    ${CONDA_ENV_PATH}/conda create -n $CONDA_ENV python=${PYTHON_VERSION}

# This is how you will activate this conda environment
ENV CONDA_ACTIVATE "source ${CONDA_ENV_PATH}/activate ${CONDA_ENV}"

RUN $CONDA_ACTIVATE && \
    pip install --upgrade pip && \
    pip --no-cache-dir install scipy numpy matplotlib h5py scikit-image \
    tqdm paramiko tensorflow-cpu numba \
    opencv-python opencv-contrib-python \
    open3d notebook jupyterlab && \
    conda install pytorch torchvision torchaudio cpuonly -c pytorch && \
    pip --no-cache-dir install kornia && \
    conda clean -ya


ENV JETBRAINS_VERSION 2022.3.1
RUN cd /home/${USER_NAME}/TOOLS && \
    wget https://download.jetbrains.com/cpp/CLion-${JETBRAINS_VERSION}.tar.gz && \
    tar -zxf CLion-${JETBRAINS_VERSION}.tar.gz
RUN cd /home/${USER_NAME}/TOOLS && \
    wget https://download.jetbrains.com/python/pycharm-community-${JETBRAINS_VERSION}.tar.gz && \
    tar -zxf pycharm-community-${JETBRAINS_VERSION}.tar.gz

RUN echo "alias i_jupyter_lab='jupyter lab --allow-root --notebook-dir=$pwd --no-browser --ip=0.0.0.0'" >> $HOME/.bashrc && \
    echo "alias i_jupyter_notebook='jupyter notebook --allow-root --notebook-dir=$pwd --no-browser --ip=0.0.0.0'" >> $HOME/.bashrc && \
    echo "alias pycharm='sh /home/"${USER_NAME}"/TOOLS/pycharm-community-"${JETBRAINS_VERSION}"/bin/pycharm.sh'" >> $HOME/.bashrc && \
    echo "alias clion='sh /home/"${USER_NAME}"/TOOLS/clion-"${JETBRAINS_VERSION}"/bin/clion.sh'" >> $HOME/.bashrc && \
    echo "PS1='\$\w >>> '" >> $HOME/.bashrc && \
    echo "$CONDA_ACTIVATE" >> $HOME/.bashrc

WORKDIR /PROJECTS

USER root
CMD service ssh start ; bash
