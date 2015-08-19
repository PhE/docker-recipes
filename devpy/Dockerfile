# devpy/DockerFile
#
# see ../README.md for usage
#

FROM phusion/baseimage:0.9.17
MAINTAINER Philippe ENTZMANN <philippe.entzmann@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# To force apt-get update
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"

# Usefull tools
RUN apt-get update && apt-get install -y \
  byobu \
  gdebi-core \
  git \
  htop \
  lynx \
  p7zip-full \
  unzip \
  wget

# Python dev stuff and depedencies not in pip packages
RUN apt-get update && apt-get install -y \
  build-essential \
  gfortran \
  libbz2-dev \
  libfreetype6-dev \
  libhdf5-serial-dev \
  liblapack-dev \
  liblzo2-dev \
  libopenblas-dev \
  libncurses-dev \
  libpng-dev \
  libxml2-dev \
  libxslt-dev \
  lib32z1-dev \
  pkg-config \
  python-dev \
  python-pip \
  texlive-latex-base \
  texlive-latex-extra \
  texlive-fonts-recommended

# Upgrade pip
# cf https://github.com/docker/docker/issues/12327
#RUN cd /tmp \
#  && wget https://bootstrap.pypa.io/get-pip.py \
#  && python get-pip.py \
#  && pip install -U pip
RUN pip install --upgrade pip==7.1.0

# Python pip packages
# pip list --outdated
COPY pip_requirement*.txt /root/
RUN pip install -r /root/pip_requirements_stage1.txt \
  && pip install -r /root/pip_requirements_stage2.txt \
  && pip install -r /root/pip_requirements_stage3.txt

# Add user Alan (with group, password, sudo)
RUN groupadd -g 1000 alan \
  && useradd -m -u 1000 -s /bin/bash -g alan alan \
  && echo 'alan:alan' | chpasswd \
  && adduser alan sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
WORKDIR /home/alan

# Set default byobu shortcut behaviour to screen (ctrl-A)
RUN /sbin/setuser alan byobu-ctrl-a screen

# Add french locale support
RUN locale-gen fr_FR.UTF-8 \
  && update-locale LANG=fr_FR.UTF-8
COPY bashrc /home/alan/.bashrc

# Tools for browsing markdown files in console
# and to convert notebook to PDF
#RUN apt-get install -y pandoc lynx
#RUN pip install grip
RUN \
  cd /tmp \
  && wget https://github.com/jgm/pandoc/releases/download/1.15.0.5/pandoc-1.15.0.5-1-amd64.deb \
  && dpkg -i pandoc-1.15.0.5-1-amd64.deb \
  && apt-get install -f \
  && rm pandoc-1.15.0.5-1-amd64.deb

# Web2py
RUN \
  cd /tmp \
  && wget http://www.web2py.com/examples/static/web2py_src.zip \
  && unzip web2py_src.zip \
  && chown -R alan:alan web2py \
  && mv web2py /opt/ \
  && rm web2py_src.zip

# Redis and jupyter redis kernel
RUN apt-get install -y redis-server \
  && pip install redis_kernel

# vim (if you prefer to edit your code inside the container)
RUN apt-get install -y vim

# atom.io
RUN cd /tmp \
  && apt-get update -y \
  && wget https://atom.io/download/deb -O atom.deb \
  && gdebi -n atom.deb \
  && rm atom.deb
# TODO:
# PYTHON=python2.7 apm install hydrogen
# install Atom packages
RUN  apm install file-icons git-plus merge-conflicts minimap

# Chromium browser
RUN apt-get install -y chromium-browser

RUN apt-get update \
  && apt-get dist-upgrade -y

# Google Chrome
RUN cd /tmp \
  && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
  && gdebi -n google-chrome*.deb \
  && rm google-chrome*.deb

# Add byobu/tmux sessions launcher script
COPY tmux_start /home/alan/

# The default folder where your target dev project should be
# This folder could be used to mount a physical folder via the -v docker option
RUN mkdir /home/alan/dev

# Network services exposed
# SSH
EXPOSE 22
# web2py
EXPOSE 7999
# jupyter notebook
EXPOSE 8888

# Start the tmux sessions
CMD ["/sbin/setuser", "alan", "/home/alan/tmux_start"]
#CMD ["/sbin/setuser", "alan", "/bin/bash"]
