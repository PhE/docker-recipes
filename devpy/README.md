# DockerFile devpy

DockerFile for my Python dev env

# Shortcuts

* http://CONTAINER_IP:5555 : IPython notebook
* http://CONTAINER_IP:7999 : Web2py (admin password : toto)

# Build image

To build and run the image :

```
docker build -t phentz/devpy:latest devpy/.
docker run -i -t --rm -v ~/dev:/home/alan/dev phentz/devpy
```

# Image features

* *atom.io* graphical IDE
* *jupyter* web-based notebook IDE
* *vim* console-based IDE
