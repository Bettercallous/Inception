FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y nginx \
    && apt-get install gettext-base

COPY /conf /tmp/

COPY /tools /etc/nginx/ssl

RUN chmod +x /tmp/script.sh

CMD ["/tmp/script.sh"]
