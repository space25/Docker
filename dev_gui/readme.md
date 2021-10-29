## Prepare Docker image
1. Build the docker image
    ```
    docker build --network host -t spacev/dev_gui .
    ```
1. Run docker container:
    ```
    docker run -it --net=host -e DISPLAY -v /tmp/.X11-unix spacev/dev_gui bash
    ```

1. Copying the Cookie to connect X Server Displays on the local machine
    ```
    xauth list
    ```

1. Add the cookie to the list in docker container
    ```
    xauth add <cookie>
    xauth list
    ```

1. Run the Apps Instance from the bash



## Links:
1. [Running GUI Applications on Docker in Linux](https://www.geeksforgeeks.org/running-gui-applications-on-docker-in-linux/)
1. [Delivering Desktop Apps in Containers](https://www.youtube.com/watch?v=L4nqky8qGm8)
