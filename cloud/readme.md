## Prepare Docker image
1. Build image
    ```
    docker build --network host -t spacev/cloud .
    ```
1. Generate encrypt certificate:
    - openssl
        ```
        openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout apache_nextcloud.key -out apache_nextcloude.crt
        ```
    - [Let’s Encrypt](https://bayton.org/docs/nextcloud/installing-nextcloud-on-ubuntu-16-04-lts-with-redis-apcu-ssl-apache/#4-2-enable-ssl)
1. Run docker:
    ```
    docker run -d -p 443:443 \
        -v ssl:/etc/apache2/ssl \
        -v html:/var/www/html \
        -v custom_apps:/var/www/html/custom_apps \
        -v config:/var/www/html/config \
        -v data:/var/www/html/data \
        spacev/cloud
    ```