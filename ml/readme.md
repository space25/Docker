## Prepare Docker image
1. Build image
    ```
    docker build --network host -t spacev/ml .
    ```
1. Run docker:
    ```
    docker run -it -v ~/Downloads/dl:/data spacev/ml /bin/bash
    ```