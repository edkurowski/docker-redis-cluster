FROM ubuntu:latest

MAINTAINER Darren Gruber <dgruber@gmail.com>

ENV HOME /root

# Some Environment Variables
ENV DEBIAN_FRONTEND noninteractive

# # Ensure UTF-8 lang and locale
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Initial update and install of dependency that can add apt-repos
RUN apt-get -y update
RUN apt-get install -y software-properties-common python-software-properties

RUN apt-get update && apt-get -y upgrade

# Install system dependencies
RUN apt-get install -y gcc make g++ build-essential libc6-dev tcl git supervisor wget

# checkout the 3.0 (Cluster support) branch from official repo
RUN wget https://github.com/antirez/redis/archive/2.8.1.tar.gz && tar xfvz 2.8.1.tar.gz

# Build redis from source
RUN (cd /redis-2.8.1 && make)

# Install ruby dependencies so we can bootstrap the cluster via redis-trib.rb
RUN apt-get -y install ruby2.0
RUN gem install redis

# Because Git cannot track empty folders we have to create them manually...
RUN mkdir /redis-data && mkdir /redis-data/7000 && mkdir /redis-data/7001 && mkdir /redis-data/7002 && mkdir /redis-data/7003 && mkdir /redis-data/7004 && mkdir /redis-data/7005

# Add all config files for all clusters
ADD ./docker-data/redis-conf /redis-conf

# Add supervisord configuration
ADD ./docker-data/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add startup script
ADD ./docker-data/start.sh /start.sh
RUN chmod 755 /start.sh

# TODO: This command is the one that should be runned but currently start.sh script crashes out with an error
# CMD ["/sbin/my_init", "--enable-insecure-key", "--", "/bin/bash -c '/start.sh'"]

CMD ["/bin/bash", "/start.sh"]
