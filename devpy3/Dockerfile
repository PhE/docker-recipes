# devpy/DockerFile
#
# see ../README.md for usage
#

FROM phusion/baseimage:0.9.18
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

# Miniconda installer
RUN mkdir /opt/install
RUN cd /opt/install \
  && wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh

RUN cd /opt/install \
 && bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b \
 && rm Miniconda3-latest-Linux-x86_64.sh

ENV PATH=/miniconda/bin:${PATH}

# conda update conda
RUN conda update -y conda

# Python packages from conda
RUN conda install -y \
    blaze \
    bokeh \
    Cython \
    distributed \
    flask \
    jupyter \
    lxml \
    matplotlib \
    numexpr \
    networkx \
    nltk \
    nose \
    pandas \
    pillow \
    Sphinx \
    openpyxl \
    pytables \
    seaborn \
    scipy \
    statsmodels \
    scikit-learn \
    xlrd \
    XlsxWriter \
    xlwt


RUN conda install -y -c r \
    r-essentials

# vim (if you prefer to edit your code inside the container)
RUN apt-get install -y vim

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
ENV LC_ALL=fr_FR.UTF-8
ENV LANG=fr_FR.UTF-8

# Tools to convert notebook to PDF
#RUN apt-get install -y pandoc
RUN \
  cd /tmp \
  && wget https://github.com/jgm/pandoc/releases/download/1.17.0.2/pandoc-1.17.0.2-1-amd64.deb \
  && dpkg -i pandoc-1.17.0.2-1-amd64.deb \
  ; apt-get install -f --yes \
  && rm pandoc-1.17.0.2-1-amd64.deb

# Netdata
# usage : /usr/sbin/netdata
# http://127.0.0.1:19999/
RUN apt-get install --yes zlib1g-dev gcc make git autoconf \
  autogen automake pkg-config \
  && git clone https://github.com/firehol/netdata.git --depth=1 \
  && cd netdata \
  && ./netdata-installer.sh --dont-wait

# nbpresent
# cf https://github.com/Anaconda-Platform/nbpresent
RUN conda install -y -c anaconda-nb-extensions nbpresent

RUN conda install -y cryptography webob

RUN pip install --upgrade \
  ipython-sql \
  quantecon \
  pyotp \
  pyqrcode

# Julia and iJulia
#RUN cd /tmp \
#  && apt-get -y install julia \
#  && julia -e 'Pkg.init()' \
#  && julia -e 'Pkg.add("IJulia")' \
#  && julia -e 'Pkg.add("QuantEcon")' \
#  && julia -e 'Pkg.add("PyPlot")'

# Torch and iTorch
#RUN cd /tmp \
#  && git clone https://github.com/torch/distro.git ~/torch --recursive \
#  && cd torch; bash install-deps; \
#  && ./install.sh \
#  && cd .. \
#  && git clone https://github.com/facebook/iTorch.git \
#  && cd iTorch
#  && luarocks make

# Redis and jupyter redis kernel
#RUN apt-get install -y redis-server \
#  && pip install redis_kernel
#RUN conda install -y -c anaconda redis=2.6.9


#RUN conda install -c https://conda.anaconda.org/nroth df2gspread
#RUN conda install -c https://conda.anaconda.org/asmeurer mrjob
#RUN conda install -c chdoig -c nbsantos mrjob
#RUN conda install -c https://conda.anaconda.org/sloria textblob \
#  && python -m textblob.download_corpora


# glusterfs
RUN apt-get install -y software-properties-common \
  && add-apt-repository ppa:gluster/glusterfs-3.7 \
  && apt-get update \
  && apt-get install -y glusterfs-server

# Add user Alan2 (with group, password, sudo)
RUN groupadd -g 40561 alan2 \
  && useradd -m -u 40561 -s /bin/bash -g alan2 alan2 \
  && echo 'alan2:alan2' | chpasswd \
  && adduser alan2 sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Add byobu/tmux sessions launcher script
COPY startup /home/alan/

# Set default byobu shortcut behaviour to screen (ctrl-A)
RUN /sbin/setuser alan2 byobu-ctrl-a screen

# Add byobu/tmux sessions launcher script
COPY startup /home/alan2/

# Network services exposed
# SSH
EXPOSE 22
# jupyter notebook
EXPOSE 8888
# netdata
EXPOSE 19999

RUN mkdir /current_dir

# Start the tmux sessions
#CMD ["/sbin/setuser", "alan", "/home/alan/startup"]
CMD ["/sbin/setuser", "alan2", "/home/alan2/startup"]
#CMD ["/sbin/setuser", "alan", "/bin/bash"]
