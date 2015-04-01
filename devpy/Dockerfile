# devpy/DockerFile
#
# see ../README.md for usage
#

FROM phusion/baseimage:0.9.16
MAINTAINER Philippe ENTZMANN <philippe.entzmann@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

# Usefull tools
RUN apt-get install -y git byobu htop

# Python dev stuff and depedencies not in pip packages
RUN apt-get install -y python-pip python-dev \
  libxml2-dev libxslt1-dev \
  gfortran libopenblas-dev liblapack-dev \
  libfreetype6-dev libhdf5-serial-dev liblzo2-dev libbz2-dev \
  pkg-config libpng-dev \
  build-essential

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
RUN apt-get install -y pandoc lynx

# Web2py
RUN apt-get install -y wget unzip
RUN \
  cd /tmp \
  && wget http://www.web2py.com/examples/static/web2py_src.zip \
  && unzip web2py_src.zip \
  && chown -R alan:alan web2py \
  && mv web2py /opt/ \
  && rm web2py_src.zip


# Add byobu/tmux sessions launcher script
ADD tmux_start /home/alan/

# vim (if you prefer to edit your code inside the container)
RUN apt-get install -y vim

# The default folder where your target dev project should be
# This folder could be used to mount a physical folder via the -v docker option
RUN mkdir /home/alan/dev

# Start the tmux sessions
CMD ["/sbin/setuser", "alan", "/home/alan/tmux_start"]
#CMD ["/sbin/setuser", "alan", "/bin/bash"]
