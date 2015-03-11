# DockerFile devpy

DockerFile for my Python dev env

# Shortcuts

* http://CONTAINER_IP:5555 : IPython notebook


# Build image

To build and run the image :

```
docker build -t phentz/devpy:latest devpy/.
docker run -i -t --rm -v ~/dev:/home/alan/dev phentz/devpy
```
