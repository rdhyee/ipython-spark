FROM ipython/scipyserver

MAINTAINER Raymond Yee  <raymond.yee@gmail.com>

RUN apt-get -y update --fix-missing
RUN apt-get -y install default-jre-headless

# RUN apt-get -y install mesos 