FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y nginx \
    && apt-get install gettext-base

COPY tools/script.sh /tmp/

COPY conf/nginx.conf.template /tmp/

RUN chmod +x /tmp/script.sh

CMD ["/tmp/script.sh"]
