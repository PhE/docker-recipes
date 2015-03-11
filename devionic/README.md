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
