# devpy/DockerFile
#
# see ../README.md for usage
#

FROM phusion/baseimage:0.9.18
MAINTAINER Philippe ENTZMANN <philippe.entzmann@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# To force apt-get update and install usefull tools
RUN apt-get update \
  && apt-get upgrade -y -o Dpkg::Options::="--force-confold" \
  && apt-get install -y \
  byobu \
  gdebi-core \
  git \
  htop \
  lynx \
  p7zip-full \
  unzip \
  vim \
  wget \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# glusterfs
RUN apt-get install -y software-properties-common \
  && add-apt-repository ppa:gluster/glusterfs-3.7 \
  && apt-get update \
  && apt-get install -y glusterfs-server \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Java
RUN apt-add-repository -y ppa:webupd8team/java \
  && apt-get update -y \
  && echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections \
  && echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections \
  && apt-get install -y oracle-java8-installer \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Miniconda installer
RUN mkdir /opt/install
RUN cd /opt/install \
  && wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
  && bash Miniconda3-latest-Linux-x86_64.sh -p /miniconda -b \
  && rm Miniconda3-latest-Linux-x86_64.sh

ENV PATH=/miniconda/bin:${PATH}

# conda update and usefull tools
RUN conda update -y conda \
    && conda install -y \
      blaze \
      bokeh \
      cryptography \
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
      webob \
      xlrd \
      XlsxWriter \
      xlwt \
    && conda install -y -c r \
      r-essentials \
    && conda install -y -c anaconda-nb-extensions \
        nbpresent \
    && conda clean -i -l -t -y

# Spark
RUN cd /opt \
  && wget http://apache.crihan.fr/dist/spark/spark-1.6.1/spark-1.6.1-bin-hadoop2.6.tgz \
  && tar xzf spark-1.6.1-bin-hadoop2.6.tgz \
  && rm spark*.tgz \
  && ls -lsah /opt


# pip packages
RUN pip install --upgrade \
  cppimport \
  ipython-sql \
  quantecon \
  pyotp \
  pyqrcode \
  python-redmine \
  && rm -rf /root/.cache/pip/*


# - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- -

# Add user Alan (with group, password, sudo)
RUN groupadd -g 1000 alan \
  && useradd -m -u 1000 -s /bin/bash -g alan alan \
  && echo 'alan:alan' | chpasswd \
  && adduser alan sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Add user Alan2 (with group, password, sudo)
RUN groupadd -g 40561 alan2 \
  && useradd -m -u 40561 -s /bin/bash -g alan2 alan2 \
  && echo 'alan2:alan2' | chpasswd \
  && adduser alan2 sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Add user Alan3 (with group, password, sudo)
RUN groupadd -g 1002 alan3 \
  && useradd -m -u 1002 -s /bin/bash -g alan3 alan3 \
  && echo 'alan3:alan3' | chpasswd \
  && adduser alan3 sudo \
  && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set default byobu shortcut behaviour to screen (ctrl-A)
RUN /sbin/setuser alan byobu-ctrl-a screen \
  && /sbin/setuser alan2 byobu-ctrl-a screen \
  && /sbin/setuser alan3 byobu-ctrl-a screen


WORKDIR /home/alan

# Add byobu/tmux sessions launcher script
COPY startup /home/alan/
COPY startup /home/alan2/
COPY startup /home/alan3/

# Add banner message
COPY banner /home/alan/
COPY README /home/alan/

RUN chown -R alan:alan /opt/spark*

# - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- - -- -

RUN mkdir /current_dir


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
RUN apt-get update \
  && apt-get install --yes \
    autoconf \
    autogen \
    automake \
    build-essential \
    gcc \
    git \
    make \
    pkg-config \
    uuid-dev \
    zlib1g-dev \
  && git clone https://github.com/firehol/netdata.git --depth=1 \
  && cd netdata \
  && ./netdata-installer.sh --dont-wait \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


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


# Network services exposed
# SSH
EXPOSE 22
# jupyter notebook
EXPOSE 8888
# netdata
EXPOSE 19999

# Start the tmux sessions
CMD ["/sbin/setuser", "alan", "/home/alan/startup"]
#CMD ["/sbin/setuser", "alan3", "/home/alan3/startup"]
