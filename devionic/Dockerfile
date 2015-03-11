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
RUN pip install couchapp

# Create user and load dummy data
ADD data_*.json /tmp/
RUN /sbin/setuser alan couchdb -b -a /home/alan/couchdb.ini && sleep 2 && \
  COUCH=http://localhost:5984 && \
  curl -HContent-Type:application/json \
    -vXPUT $COUCH/_users/org.couchdb.user:toto \
    --data-binary '{"_id": "org.couchdb.user:toto","name": "toto","roles": ["poc"],"type": "user","password": "titi"}' \
  curl -X PUT http://localhost:5984/dummy && \
  curl -d @/tmp/data_dummy.json -H "Content-type: application/json" \
    -X POST http://localhost:5984/dummy/_bulk_docs && \
  /sbin/setuser alan couchdb -d && \
  rm /tmp/data_*.json

# COUCH=http://ADMIN_USERNAME:ADMIN_PASSWORD@localhost:5984

# usefull ? runas alan ?
#RUN bower --allow-root install | xargs echo

ADD README.md /home/alan/
RUN pandoc /home/alan/README.md -o /home/alan/README.html

# Use parent tmux session script
ADD tmux_start /home/alan/
