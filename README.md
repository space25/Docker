# Docker

## Install Docker:

1. [Get Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/) or

        sudo snap install docker

2. [Post-installation steps for Linux](https://docs.docker.com/install/linux/linux-postinstall/)
3. Verify that Docker CE is installed correctly by running the Ubuntu image:

        docker run docker/whalesay cowsay HI

4. [Get started with Docker](https://docs.docker.com/get-started/)

## Operation with docker

- Run a container in an interactive mode:

        docker run -it ubuntu bash

- To see are running containers:

        docker ps

- To see all containers:

        docker ps -a

- To see all images:

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

## Links

1. [15 Docker Commands Beginners Should Know](https://dev.to/kojikanao/15-docker-commands-for-beginners-4m4d)
2. [Docker Tutorial for Beginners - A Full DevOps Course on How to Run Applications in Containers](https://www.youtube.com/watch?v=fqMOX6JJhGo)