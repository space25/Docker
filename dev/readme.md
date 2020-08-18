### Config Visual Studio Code:
1. On VScode: CTRL + Shift + P
1. Choose "Preferences: Open Settings (JSON)"
1. Add this line into JSON file:
    ```
    "python.linting.pylintArgs": ["--generate-members"]
    ```


### Config system:
1. Generating a new SSH key

    Linux
    ```
    ssh-keygen -t rsa -b 4096 -f ${HOME}/.ssh/linux_rsa
    ```
    Windows 10:
    ```
    ssh-keygen -t rsa -b 4096 -f %USERPROFILE%/.ssh/linux_rsa
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


## Links:
1. [Visual Studio Code Remote Development through SSH](https://www.youtube.com/watch?v=lKXMyln_5q4)
1. [Quickly get up and running with CMake in VS Code](https://www.youtube.com/watch?v=9thQdjvVD9k)
1. [cv2 module members are not recognized](https://github.com/PyCQA/pylint/issues/2426)
1. [Visual Studio Code - How to add multiple paths to python path?](https://stackoverflow.com/questions/41471578/visual-studio-code-how-to-add-multiple-paths-to-python-path)
