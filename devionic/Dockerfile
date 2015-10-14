# devionic/DickerFile
#
# see README.md for usage
#

FROM phentz/devpy:latest
MAINTAINER Philippe ENTZMANN <philippe.entzmann@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash - && \
    apt-get install -y nodejs

# Install Ionic tools
RUN npm install -g ionic bower cordova

# Install yeoman and ionic generator
RUN npm install -g yo generator-ionic grunt-cli

# CouchDB server and tools
# The version in the repo doesn't handle CORS, so we need a more recent one,
# at least 1.6.1 :
# cf https://launchpad.net/~couchdb/+archive/ubuntu/stable
#ENV COUCH http://127.0.0.1:5984
#RUN apt-get install -y software-properties-common && \
#    add-apt-repository ppa:couchdb/stable -y && \
#    apt-get update -y && \
#    apt-get install -y couchdb
#RUN mkdir /var/run/couchdb
#ADD couchdb.ini /home/alan/
##RUN npm install -g add-cors-to-couchdb && \
##  couchdb should be run wih alan user (not root)
#RUN chown -R alan:alan /etc/couchdb && \
#  chown -R alan:alan /var/lib/couchdb && \
#  chown -R alan:alan /var/log/couchdb && \
#  chown -R alan:alan /var/run/couchdb && \
#  chown -R alan:alan /var/run/couchdb
## Filesystem sync for couchdb dev via git
#RUN pip install couchapp couchdb

# Create user and load dummy data
# COUCH=http://ADMIN_USERNAME:ADMIN_PASSWORD@localhost:5984
#ADD data_*.mime /tmp/
#RUN /sbin/setuser alan couchdb -b -a /home/alan/couchdb.ini && sleep 2 && \
#  curl -X PUT http://127.0.0.1:5984/dummy && \
#  couchdb-load --input=/tmp/data_dummy.mime http://127.0.0.1:5984/dummy && \
##  curl -HContent-Type:application/json \
##    -vXPUT http://127.0.0.1:5984/_users/org.couchdb.user:toto \
##    --data-binary '{"_id": "org.couchdb.user:toto","name": "toto","roles": ["poc"],"type": "user","password": "titi"}' \
#  sleep 2 && /sbin/setuser alan couchdb -d && \
#  rm /tmp/data_*.mime


# usefull ? runas alan ?
#RUN bower --allow-root install | xargs echo

# Create an empty ionic project
# echo n for 'no' to the ionic.io question
#RUN \
#  cd /home/alan/dev \
#  && echo n | ionic start myApp tabs

#ADD README.rst /home/alan/
#RUN pandoc /home/alan/README.rst -o /home/alan/README.html

# Some usefull package
RUN npm install -g ws

RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y nginx

RUN rm -rf /var/lib/apt/lists/* && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
    chown -R www-data:www-data /var/lib/nginx

# tmux start session script
COPY tmux_start /home/alan/
RUN chown alan:alan /home/alan/tmux_start

ADD https://github.com/hiteshjasani/nim-mungehosts/releases/download/v0.1.1/mungehosts /usr/local/bin/mungehosts
RUN chmod 755 /usr/local/bin/mungehosts

# Start the tmux sessions
CMD ["/sbin/setuser", "alan", "/home/alan/tmux_start"]
