FROM gitpod/workspace-full:latest

# set environment vars
ENV HADOOP_HOME /home/gitpod/hadoop-2.10.0

# install packages
# RUN \
#   apt-get update && apt-get install -y \
#   ssh \
#   rsync \
#   vim \
#   openjdk-8-jdk



RUN \
    wget https://www-eu.apache.org/dist/hadoop/common/hadoop-2.10.0/hadoop-2.10.0.tar.gz && \
    tar -zxf hadoop-2.10.0.tar.gz && \
    # mv hadoop-2.10.0 /workspace && \
    # echo "export JAVA_HOME=$JAVA_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh && \
    echo "PATH=$PATH:$HADOOP_HOME/bin" >> ~/.bashrc
