# docker-recipes

My public Docker recipes.

A collection of DockerFile used to speed up new development environment creation.

# Features

* A dummy user **alan** with gid/uid 1000 that match your local files permissions
* A byobu/tmux startup script to ease multiple commands/process launch
* A bunch of Python packages usefull to start a fresh project

# Install


```
docker login
```

To build a Docker image, go to one folder containing a DockerFile,
then build the image :

```
docker build -t phentz/devpy:latest devpy/.
```

```
docker build -t phentz/devionic:latest devionic/.
```

# Usage


Simple case of launching a new container :

```
docker run -i -t --rm phentz/devpy
```

Want to code on an existing repo on your host ?
We assume your repo is under ~/dev.
Start a container with :

```
docker run -i -t --rm -v ~/dev:/home/alan/dev phentz/devpy
```

# Pushing a new release


Add a tag

```
git tag
```

```
git tag 20150305
```


```
git push --tags
```

NEW_TAG could be 'latest'

```
export NEW_TAG=20150312
export IMAGE=devpy

docker build -t phentz/$IMAGE:$NEW_TAG $IMAGE/.
docker push phentz/$IMAGE:$NEW_TAG
```



# TODO

* Add python 3 support in notebook
* Add terminal support in notebook
* Add ionic
* Add cordova
* Add Android SDK for emulation
* Add couchdb
* Add selenium
* Add protractor
* Add redis
* Add crossbar.io
* Add web2py
