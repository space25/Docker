## Prepare Docker image
1. Build image:
    ```
    docker build --network host -t spacev/dl .
    ```
1. Run docker:
    ```
    docker run -it -v ~/Downloads/dl:/data spacev/dl /bin/bash
    ```
## Download from youtube
1. Download playlist:
    ```
    youtube-dl --yes-playlist <url>
    ```
    or with autonumber:
    ```
    youtube-dl -cio '%(autonumber)s-%(title)s.%(ext)s' <url>
    ```
1. Download mp3:
    ```
    youtube-dl --extract-audio --audio-format mp3 <url>
    ```
## Download from Coursera
1. coursera-dl -u <user> -p <pass> modelthinking-004

## After download:
```
sudo chmod -R 777 .
```