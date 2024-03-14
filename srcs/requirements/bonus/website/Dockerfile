FROM debian:bullseye

RUN apt-get update -y && apt-get install php -y

COPY tools/index.html /var/www/html/

CMD	["php", "-S", "[::]:80", "-t", "/var/www/html"]