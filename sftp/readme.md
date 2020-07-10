## Run sftp Docker image ([git](https://github.com/atmoz/sftp))
```
docker run \
    -v /host/upload:/home/foo/upload \
    -p 2222:22 -d atmoz/sftp \
    foo:pass:1001
```
or
```
docker run \
    -p 2222:22 \
    -d \
    -v /host/upload:/home/foo/upload \
    atmoz/sftp \
    foo:pass:::upload
```
