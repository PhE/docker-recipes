.. contents:: :local:

docker-recipes
====================

My public Docker recipes.

A collection of DockerFile used to speed up new development environment creation.


* `devpy`_ : Python development container
* `devionic`_: : Ionic development container

.. _devpy: devpy/README.rst
.. _devionic: devionic/README.rst


Features
------------

* A dummy user **alan** with gid/uid 1000 that match your local files permissions
* A byobu/tmux startup script to ease multiple commands/process launch
* A bunch of Python packages usefull to start a fresh project

* Redis server
* jupyter server


Install
--------------


.. code:: Bash

  docker login


To build a Docker image, go to one folder containing a DockerFile,
then build the image :

.. code:: Bash

  docker build -t phentz/devpy:latest devpy/.
  docker build -t phentz/devionic:latest devionic/.


Usage
-------------


Simple case of launching a new container :

.. code:: Bash

  docker run -i -t --rm phentz/devpy


Want to code on an existing repo on your host ?
We assume your repo is under ~/dev.
Start a container with :

.. code:: Bash

  docker run -i -t --rm -v ~/dev:/home/alan/dev phentz/devpy


Need to launch a graphical application from your container ?
(Thanks to http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)

.. code:: Bash

  docker run -it --rm \
      -v $HOME/.Xauthority:/root/.Xauthority \
      -e DISPLAY \
      --net=host \
      phentz/devpy


Build and run automation
-----------------------------

You can have a *docker_build* and *docker_run* scripts in each of your project
that will automate the process of building the container image and running it.

Let's say that you have a *docker_run* script located in a *bin* folder of
your project.
The name of your project is the name of the folder containing
the *bin* folder.
Your project if git versioned.
This script will run the container based on the image *$APP_NAME-$BRANCH*.

.. code:: Bash

  # Full path of this script
  SCRIPT=$(readlink -f $0)

  # Full path of this script directory
  SCRIPT_FOLDER=$(dirname $SCRIPT)

  # Full path of the project (parent directory)
  export APP_FOLDER=$(readlink -f $SCRIPT_FOLDER/..)

  # Application/project name
  export APP_NAME=$(basename $APP_FOLDER)

  # Current git branch
  BRANCH=$(cd $APP_FOLDER && git rev-parse --abbrev-ref HEAD)

  # Run the container
  docker run -it --rm \
      -v $APP_FOLDER:/var/$APP_NAME \
      -v $HOME/.Xauthority:/root/.Xauthority \
      -e DISPLAY \
      --net=host \
      $APP_NAME-$BRANCH \
      $1 $2 $3 $4 $5


Pushing a new release
------------------------

Degine the release tag :

.. code:: Bash

  export NEW_TAG=20150312


or

.. code:: Bash

  export NEW_TAG=latest



List existing tags

.. code:: Bash

  git tag


Add a tag

.. code:: Bash

  git tag -f $NEW_TAG


Push tags to remote repository

.. code:: Bash

  git push -f --tags


.. code:: Bash

  export IMAGE=devpy

  docker build -t phentz/$IMAGE:$NEW_TAG $IMAGE/.
  docker push phentz/$IMAGE:$NEW_TAG


TODO
=======

* Add python 3 support in notebook
* Add terminal support in notebook
* Add cordova
* Add Android SDK for emulation
* Add selenium
* Add protractor
* Add crossbar.io
* Add notebook import feature (cf http://www.motleytech.net/en/2015/09/14/importing-ipython-notebook-another-notebook/)
* Add sqlalchemy library
* Add Click library (http://click.pocoo.org/5/)
