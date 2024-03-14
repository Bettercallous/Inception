FROM debian:bullseye

RUN apt-get update -y && apt-get install redis -y && \
    echo "maxmemory 256mb" >> /etc/redis/redis.conf && \
    echo "maxmemory-policy allkeys-lru" >> /etc/redis/redis.conf && \
    sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/" /etc/redis/redis.conf

CMD ["redis-server", "--protected-mode", "no"]