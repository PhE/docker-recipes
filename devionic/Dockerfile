# docker build -t devionic .
#
# docker run -i -t --rm -v ~/dev:/home/alan/dev devionic
#

FROM phentz/docker-devpy:latest
MAINTAINER Philippe ENTZMANN <philippe.entzmann@gmail.com>

ADD tmux_start /home/alan/

CMD ["/sbin/setuser", "alan", "/home/alan/tmux_start"]
#CMD ["/sbin/setuser", "alan", "/bin/bash"]
