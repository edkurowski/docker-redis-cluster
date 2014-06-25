# docker-redis-cluster

Docker image that will install redis from source and start a redis cluster.

The cluster is 6 redis instances running with 3 master & 3 slaves, one slave for each master.

This has been altered to run the  2.8.1 branch of redis git repo (https://github.com/antirez/redis).



## Setup

How to setup docker and start the cluster image.

- Install lxc-docker on your system (I currently use Docker version 0.11.0) (Instructions can be found at: http://docs.docker.io/en/latest/installation/)
- Navigate to root of this project
- Run 'make docker-build'
- Run one of
  
  - 'make docker-run' to start the server and tail first redis server (the one creating the cluster)
  - 'make docker-run-d' to run it in the background
  - 'make docker-run-interactive' starts /bin/bash (good for debugging) [start.sh have to be runned manually. No cluster will be created, Supervisord will not start automatically]

- Test the connection by running either 'redis-cli -p 7000' (or any other cluster port)
