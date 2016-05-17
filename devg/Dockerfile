# devpy/DockerFile
#
# see ../README.md for usage
#

FROM phentz/devpy3:latest
MAINTAINER Philippe ENTZMANN <philippe.entzmann@gmail.com>

# atom.io
RUN cd /tmp \
  && wget https://atom.io/download/deb -O atom.deb \
  && apt-get update -y \
  && gdebi -n atom.deb \
  && rm atom.deb

# atom.io packages
# TODO:
# PYTHON=python2.7 apm install hydrogen
# install Atom packages
RUN /sbin/setuser alan apm install \
  atom-beautify \
  atom-pair \
  atom-typescript \
  file-icons \
  git-control \
  git-plus \
  linter \
  merge-conflicts \
  minimap \
  Remote-FTP

RUN apt-get install -y build-essential
RUN apt-get install -y libzmq-dev

RUN /sbin/setuser alan apm install \
  hydrogen

# Spyder
RUN conda install -y spyder

# Google Chrome
