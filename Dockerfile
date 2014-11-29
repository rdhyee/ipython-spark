FROM ipython/scipyserver

MAINTAINER Raymond Yee  <raymond.yee@gmail.com>

RUN apt-get -y update --fix-missing
RUN apt-get -y install default-jre-headless

# Setup
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF

# Add the repository

RUN DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') && \
    CODENAME=$(lsb_release -cs) && \
    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | \
       tee /etc/apt/sources.list.d/mesosphere.list
       
       
RUN apt-get -y update

RUN apt-get -y install mesos 