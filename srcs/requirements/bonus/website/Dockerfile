FROM debian:bullseye

RUN apt-get update -y && apt-get install nginx -y

COPY conf/nginx.conf /etc/nginx/conf.d/

COPY tools/* /var/www/html/

CMD ["nginx", "-g", "daemon off;"]