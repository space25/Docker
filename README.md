# Docker

## Install Docker:

1. [Install Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
   ```
   sudo snap install docker
   ```
1. [Optional] Add GPU support:
    * [Install CUDA Toolkit](https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&target_distro=Ubuntu&target_version=1804&target_type=debnetwork)
    * [Install nvidia-docker](https://github.com/NVIDIA/nvidia-docker)
    * Check usage:
        ```
        sudo docker run --gpus all nvidia/cuda:10.0-base nvidia-smi
        ```
1. [Post-installation steps for Linux](https://docs.docker.com/install/linux/linux-postinstall/)
   ```
   sudo groupadd docker # Create the docker group.
   ```
   ```
   sudo usermod -aG docker $USER # Add your user to the docker group.
   ```
1. Verify that Docker CE is installed correctly by running the Ubuntu image:

        docker run docker/whalesay cowsay "HI $(docker --version)"

1. [Get started with Docker](https://docs.docker.com/get-started/)

## Operation with docker

- Run a container in an interactive mode:

        docker run -it ubuntu bash

- To check are running containers:

        docker ps

- Check containers:

        docker ps -a

- Check images:

        docker images

- Execute command in container:

        docker exec -it <id> /bin/bash

- Build a image:

        docker build --network host -t '<name>':'<version>' .

- Exit from a container without stopping it:

        CTRL + P + Q

- Stop a container from outside of the container:

        docker stop <container id or name>

- Kill a container from outside of the container

        docker kill <container id or name>

- Restart a container:

        docker start <container id>

- Attach to a container:

        docker attach <container id>

- Create an image from a container:

        docker commit <container id> <image name>

- [Purging All Unused or Dangling Images, Containers, Volumes, and Networks](https://www.digitalocean.com/community/tutorials/how-to-remove-docker-images-containers-and-volumes)

    Docker provides a single command that will clean up any resources — images, containers, volumes, and networks — that are dangling (not associated with a container):

        docker system prune

    To additionally remove any stopped containers and all unused images (not just dangling images), add the -a flag to the command:

        docker system prune -a

- Port mapping:

        docker run -d -p 5001:80

        docker run -it -p 8885:8888 <name>

- Volume mapping:

        docker run -it -v ~/Downloads:/data ubuntu /bin/bash

- Container logs in a detach mode:

        docker logs <container_d>

- Other:

    '-d' run in the background

    '-it' launch interactive mode

    Path to docker containers /var/lib/docker/aufs/diff/. Docker files

        sudo ls -l /var/lib/docker/aufs/diff/

## [Optional] Add support aarch64
- Install QEMU:
    ```commandline
    sudo apt update -y && sudo apt upgrade -y && sudo apt install -y qemu-kvm bridge-utils libvirt-daemon virt-manager \
    libvirt-clients libvirt-daemon-system qemu binfmt-support qemu-user-static
    ```
    ```commandline
    sudo adduser $USER libvirt
    ```
- Enable support for aarch64 containers on your x86 workstation (This step will execute the registering scripts):
    ```commandline
    docker run --rm --privileged multiarch/qemu-user-static --reset -p yes
    ```
- Testing the emulation environment:
    ```commandline
    docker run --rm -t arm64v8/ubuntu uname -m # Testing the emulation environment
    ```
    #aarch64
- Run ubuntu 24.04 aarch64 dicker:
    ```commandline
    docker run -it -p 1022:22 --platform linux/arm64/v8 ubuntu:24.04 bash
    ```

## Links

1. [15 Docker Commands Beginners Should Know](https://dev.to/kojikanao/15-docker-commands-for-beginners-4m4d)
2. [Docker Tutorial for Beginners - A Full DevOps Course on How to Run Applications in Containers](https://www.youtube.com/watch?v=fqMOX6JJhGo)
3. [Running and Building ARM Docker](https://www.stereolabs.com/docs/docker/building-arm-container-on-x86/)
