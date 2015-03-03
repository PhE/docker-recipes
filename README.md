# docker-recipes

My public Docker recipes.

A collection of DockerFile used to speed up new development environment creation.

# Features

* A dummy user **alan** with gid/uid 1000 that match your local files permissions
* A byobu/tmux startup script to ease multiple commands/process launch
* A bunch of Python packages usefull to start a fresh project

# Install

To build a Docker image, go to one folder containing a DockerFile,
then build the image :

```
cd devpy
docker build -t devpy .
```


# Usage

You can start a container based on a previously generated image with :

```
docker run -i -t --rm -v ~/dev:/home/alan/dev devpy
```
