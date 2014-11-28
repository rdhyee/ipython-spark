FROM ipython/scipyserver

MAINTAINER Raymond Yee  <raymond.yee@gmail.com>

RUN apt-get -y update --fix-missing
RUN apt-get -y install default-jre-headless

# Setup
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF

ENV DISTRO $(lsb_release -is | tr '[:upper:]' '[:lower:]') 
ENV CODENAME $(lsb_release -cs)

RUN echo $DISTRO

# Add the repository
RUN echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | \
   tee /etc/apt/sources.list.d/mesosphere.list
RUN apt-get -y update

RUN apt-get -y install mesos 