## Prepare Docker image
1. Build image:
    ```
    docker build --network host -t share .
    ```
1. Run docker:
    ```
    docker run -it -u $(id -u):$(id -g) -p 22:22 -v ~/Documents:/data  share /bin/bash
    ```
1. Start ssh server:
    ```
    echo 'root:<password!>' | chpasswd && service ssh start
    ```
    
