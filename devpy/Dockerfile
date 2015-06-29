# devpy/DockerFile
#
# see ../README.md for usage
#

FROM phusion/baseimage:0.9.16
MAINTAINER Philippe ENTZMANN <philippe.entzmann@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# To force apt-get update :
RUN touch /tmp/tmp23 \
  && apt-get update -y

# Usefull tools
RUN apt-get install -y \
  byobu \
  gdebi-core \
  git \
  htop \
  lynx \
  p7zip-full \
  unzip \
  wget

# Python dev stuff and depedencies not in pip packages
RUN apt-get install -y \
  build-essential \
  gfortran \
  libbz2-dev \
  libfreetype6-dev \
  libhdf5-serial-dev \
  liblapack-dev \
  liblzo2-dev \
  libopenblas-dev \
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

# Python pip packages
ADD pip_requirement*.txt /root/
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
ADD bashrc /home/alan/.bashrc

# Tools for browsing markdown files in console
#RUN apt-get install -y pandoc lynx
#RUN pip install grip

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
  && wget https://atom.io/download/deb -O atom.deb\
  && gdebi -n atom.deb \
  && rm atom.deb

# Chromium browser
RUN apt-get install -y chromium-browser

# Add byobu/tmux sessions launcher script
ADD tmux_start /home/alan/

# The default folder where your target dev project should be
# This folder could be used to mount a physical folder via the -v docker option
RUN mkdir /home/alan/dev

# Start the tmux sessions
CMD ["/sbin/setuser", "alan", "/home/alan/tmux_start"]
#CMD ["/sbin/setuser", "alan", "/bin/bash"]
