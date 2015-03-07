# docker build -t devionic .
#
# docker run -i -t --rm -v ~/dev:/home/alan/dev devionic
#

FROM phentz/docker-devpy:latest
MAINTAINER Philippe ENTZMANN <philippe.entzmann@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y nodejs-legacy npm

# CouchDB server and tools
# The version in the repo doesn't handle CORS, so we need a more recent one,
# at least 1.6.1 :
# cf https://launchpad.net/~couchdb/+archive/ubuntu/stable
RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:couchdb/stable -y && \
    apt-get update -y && \
    apt-get install -y couchdb
RUN mkdir /var/run/couchdb
ADD couchdb.ini /etc/couchdb/local.ini
#RUN npm install -g add-cors-to-couchdb && \
#  add-cors-to-couchdb
#RUN pip install couchapp

# nodejs, ionic, stuff
# cf https://registry.hub.docker.com/u/nicopace/ionic-cordova-android-vagrant-/dockerfile/
RUN npm install -g cordova \
  && npm install -g ionic \
  && npm install -g bower
#  && ln -s /usr/bin/nodejs /usr/bin/node

# usefull ? runas alan ?
#RUN bower --allow-root install | xargs echo

#ADD tmux_start /home/alan/

CMD ["/sbin/setuser", "alan", "/home/alan/tmux_start"]
#CMD ["/sbin/setuser", "alan", "/bin/bash"]
