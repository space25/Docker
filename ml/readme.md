## Prepare Docker image
1. Build image
    ```
    docker build --network host -t spacev/ml .
    ```
1. Run docker:
    ```
    docker run -it -v ~/Downloads/dl:/data spacev/ml /bin/bash
    ```
1. Check cuda version:
    ```
    cat /usr/local/cuda/version.txt
    ```
1. Check nvidia drivers:
    ```
    nvidia-smi
    ```