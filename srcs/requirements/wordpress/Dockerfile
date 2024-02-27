FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get install php-fpm php-mysql -y && apt-get install curl -y

COPY ./conf/wp-config-create.sh .

RUN chmod +x wp-config-create.sh

CMD ["/wp-config-create.sh"]