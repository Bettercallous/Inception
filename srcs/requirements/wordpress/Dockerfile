FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install php-fpm php7.4-mysqlnd -y \
    && apt-get install curl -y

COPY ./tools/wp-config.php .
COPY ./conf/wp-config-create.sh .

RUN chmod +x wp-config-create.sh && chmod +x wp-config.php

CMD ["/wp-config-create.sh"]