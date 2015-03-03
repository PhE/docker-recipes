# docker build -t devpy .
#
# docker run -i -t --rm -v ~/dev:/home/developer/dev devpy
#

FROM phusion/baseimage:0.9.16
MAINTAINER Philippe ENTZMANN <philippe.entzmann@gmail.com>

RUN apt-get update

# Python dev stuff
RUN apt-get install -y git python-pip
RUN apt-get install -y python-dev byobu htop
RUN apt-get install -y gfortran libopenblas-dev liblapack-dev
RUN apt-get install -y libfreetype6-dev libhdf5-serial-dev liblzo2-dev libbz2-dev pkg-config libpng-dev
RUN apt-get install -y build-essential

ADD pip_requirement*.txt /root/
RUN pip install -r /root/pip_requirements_stage1.txt
RUN pip install -r /root/pip_requirements_stage2.txt
RUN pip install -r /root/pip_requirements_stage3.txt

# Add user Alan
RUN groupadd alan \
  && useradd -m -u 1000 -s /bin/bash -g alan alan

WORKDIR /home/alan
ADD tmux_start /home/alan/

# Set default byobu shortcut behaviour to screen
RUN /sbin/setuser alan byobu-ctrl-a screen

CMD ["/sbin/setuser", "alan", "/home/alan/tmux_start"]
#CMD ["/sbin/setuser", "alan", "/bin/bash"]
