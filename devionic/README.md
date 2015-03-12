# DockerFile devionic

DockerFile for my Ionic+Python dev env

# Shortcuts

* _couchdb_ : start the couchdb server
* http://CONTAINER_IP::5984/_utils : Futon Couchdb admin interface


# Build image

To build and run the image :

```
docker build -t phentz/devionic:latest devionic/.
docker run -i -t --rm -v ~/dev:/home/alan/dev phentz/devionic
```

# Couchdb data

A dummy database is present.
To update dummy data :
```
couchdb-dump http://localhost:5984/dummy2 > data_dummy.mime
```

The couchdb-load conterpart is in the Dockerfile.
