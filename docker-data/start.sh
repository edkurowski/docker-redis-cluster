supervisord
sleep 3
/redis/src/redis-server /redis-conf/7000/redis.conf
/redis/src/redis-server /redis-conf/7001/redis.conf
/redis/src/redis-server /redis-conf/7002/redis.conf
/redis/src/redis-server /redis-conf/7003/redis.conf
/redis/src/redis-server /redis-conf/7004/redis.conf
/redis/src/redis-server /redis-conf/7005/redis.conf
tail -f /var/log/supervisor/redis-1.log
