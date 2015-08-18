# devionic/DickerFile
#
# see README.md for usage
#

FROM phentz/devpy:latest
MAINTAINER Philippe ENTZMANN <philippe.entzmann@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install -y nodejs-legacy npm

# nodejs, ionic, stuff
# cf https://registry.hub.docker.com/u/nicopace/ionic-cordova-android-vagrant-/dockerfile/
RUN npm install -g cordova \
  && npm install -g ionic \
  && npm install -g bower

# CouchDB server and tools
# The version in the repo doesn't handle CORS, so we need a more recent one,
# at least 1.6.1 :
# cf https://launchpad.net/~couchdb/+archive/ubuntu/stable
ENV COUCH http://127.0.0.1:5984
RUN apt-get install -y software-properties-common && \
    add-apt-repository ppa:couchdb/stable -y && \
    apt-get update -y && \
    apt-get install -y couchdb
RUN mkdir /var/run/couchdb
ADD couchdb.ini /home/alan/
#RUN npm install -g add-cors-to-couchdb && \
#  couchdb should be run wih alan user (not root)
RUN chown -R alan:alan /etc/couchdb && \
  chown -R alan:alan /var/lib/couchdb && \
  chown -R alan:alan /var/log/couchdb && \
  chown -R alan:alan /var/run/couchdb && \
  chown -R alan:alan /var/run/couchdb
# Filesystem sync for couchdb dev via git
RUN pip install couchapp couchdb

# Create user and load dummy data
# COUCH=http://ADMIN_USERNAME:ADMIN_PASSWORD@localhost:5984
ADD data_*.mime /tmp/
RUN /sbin/setuser alan couchdb -b -a /home/alan/couchdb.ini && sleep 2 && \
  curl -X PUT http://127.0.0.1:5984/dummy && \
  couchdb-load --input=/tmp/data_dummy.mime http://127.0.0.1:5984/dummy && \
#  curl -HContent-Type:application/json \
#    -vXPUT http://127.0.0.1:5984/_users/org.couchdb.user:toto \
#    --data-binary '{"_id": "org.couchdb.user:toto","name": "toto","roles": ["poc"],"type": "user","password": "titi"}' \
  sleep 2 && /sbin/setuser alan couchdb -d && \
  rm /tmp/data_*.mime


# usefull ? runas alan ?
#RUN bower --allow-root install | xargs echo

# Create an empty ionic project
# echo n for 'no' to the ionic.io question
RUN \
  cd /home/alan/dev \
  && echo n | ionic start myApp tabs

#ADD README.rst /home/alan/
#RUN pandoc /home/alan/README.rst -o /home/alan/README.html

# tmux start session script
ADD tmux_start /home/alan/
