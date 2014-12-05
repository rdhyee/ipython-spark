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

RUN apt-get install wget

RUN cd / && wget http://d3kbcqa49mib13.cloudfront.net/spark-1.1.1-bin-hadoop1.tgz

RUN cd / && \
    tar -xvpf /spark-1.1.1-bin-hadoop1.tgz && \
    mv /spark-1.1.1-bin-hadoop1 /spark

ENV MESOS_JAVA_NATIVE_LIBRARY /usr/local/lib/libmesos-0.21.0.so
ENV SPARK_HOME /spark
ENV PYTHONPATH /home/spark/python/:/spark/python/lib/py4j-0.8.2.1-src.zip


ADD spark-notebook.sh /spark-notebook.sh
ADD log4j.properties /spark/conf/log4j.properties

VOLUME ["/notebooks", "/data"]

EXPOSE 8888

CMD /spark-notebook.sh