## Run sftp Docker image ([git](https://github.com/atmoz/sftp))
### Read only
```
docker run \
    -v ${HOME}/upload:/home/storage/upload \
    -p 2222:22 -d atmoz/sftp \
    storage:pass:1001
```

### Read/Write
```
docker run \
    -p 2222:22 \
    -d \
    -v ${HOME}/upload:/home/storage/upload \
    atmoz/sftp \
    storage:pass:::upload
```
