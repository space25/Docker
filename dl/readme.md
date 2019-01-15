## Prepare Docker image
1. Build image
    ```
    docker build --network host -t dl .
    ```
1. Run docker:
    ```
    docker run -it -v ~/Downloads/dl:/data dl /bin/bash
    ```
## Download from youtube
1. Download playlist
    ```
    youtube-dl --yes-playlist <url>
    ```
    or
    ```
    youtube-dl -cio '%(autonumber)s-%(title)s.%(ext)s' <url>
    ```
1. Download mp3:
    ```
    youtube-dl --yes-playlist --audio-format mp3 <url>
    ```
## Download from Coursera
1. coursera-dl -u <user> -p <pass> modelthinking-004

## After cownload:
```
chmod -R 777 .
```