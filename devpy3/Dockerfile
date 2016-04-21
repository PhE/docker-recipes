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
    scipy \
    statsmodels \
    scikit-learn \
    xlrd \
    XlsxWriter \
    xlwt

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

#RUN conda install -y \
#    mrjob \
#    textblob \
#    textblob-fr

#RUN conda install -c https://conda.anaconda.org/nroth df2gspread
#RUN conda install -c https://conda.anaconda.org/asmeurer mrjob
#RUN conda install -c chdoig -c nbsantos mrjob
#RUN conda install -c https://conda.anaconda.org/sloria textblob \
#  && python -m textblob.download_corpora

# Add byobu/tmux sessions launcher script
COPY startup /home/alan/

# Network services exposed
# SSH
EXPOSE 22
# jupyter notebook
EXPOSE 8888

RUN mkdir /current_dir

# Start the tmux sessions
CMD ["/sbin/setuser", "alan", "/home/alan/startup"]
#CMD ["/sbin/setuser", "alan", "/bin/bash"]
