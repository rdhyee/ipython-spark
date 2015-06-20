FROM rdhyee/scipyserver-ansible

MAINTAINER Raymond Yee  <raymond.yee@gmail.com>

# outline of this Dockerfile drawn from https://issues.apache.org/jira/browse/SPARK-2691#comment-14194679

RUN apt-get -y update --fix-missing
RUN apt-get -y install default-jre-headless

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv E56151BF

# Add the repository

RUN DISTRO=$(lsb_release -is | tr '[:upper:]' '[:lower:]') && \
    CODENAME=$(lsb_release -cs) && \
    echo "deb http://repos.mesosphere.io/${DISTRO} ${CODENAME} main" | \
       tee /etc/apt/sources.list.d/mesosphere.list
       
       
RUN apt-get -y update --fix-missing
RUN apt-get -y install mesos

RUN apt-get install wget

# RUN cd / && wget http://d3kbcqa49mib13.cloudfront.net/spark-1.1.1-bin-hadoop1.tgz
# RUN cd / && wget http://d3kbcqa49mib13.cloudfront.net/spark-1.2.0-bin-hadoop1.tgz
# RUN cd / && wget  http://apache.mirrors.pair.com/spark/spark-1.2.2/spark-1.2.2-bin-hadoop1.tgz
RUN cd / && wget http://apache.mirrors.pair.com/spark/spark-1.4.0/spark-1.4.0-bin-hadoop1.tgz


RUN cd / && \
    tar -xvpf /spark-1.4.0-bin-hadoop1.tgz && \
    mv /spark-1.4.0-bin-hadoop1 /spark

ENV MESOS_JAVA_NATIVE_LIBRARY /usr/local/lib/libmesos-0.21.0.so

# apparently need gfortran 
# https://spark.apache.org/docs/1.2.0/mllib-guide.html#dependencies

RUN apt-get -y install libgfortran3

# http://www.abisen.com/spark-from-ipython-notebook.html
ENV SPARK_HOME /spark
ENV PYTHONPATH /spark/python/:/spark/python/lib/py4j-0.8.2.1-src.zip


ADD log4j.properties /spark/conf/log4j.properties

VOLUME ["/notebooks", "/data"]

# 8888 for the notebook, 4040 for the spark web ui
EXPOSE 8888 4040

CMD /notebook.sh
