1. Generating a new SSH key
    ```
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
    ```
1. Rename the public key to authorized_keys:
1. Run docker image:
    ```
    docker run -p 2211:22 -it -v ${HOME}/project/:/project -v ${HOME}/<pub_key_path>/:/root/.ssh spacev/ml:cpu bash
    ```
1. Set password:
    ```
    echo 'root:<password!>' | chpasswd
    ```
1. Start ssh server:
    ```
    service ssh start
    ```
