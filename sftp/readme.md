## Run sftp Docker image
```
docker run -it -v /home/<user_name>/Downloads/dl:/home/storage/upload -p 2222:22 -d atmoz/sftp:debian  storage:pass:1001
```