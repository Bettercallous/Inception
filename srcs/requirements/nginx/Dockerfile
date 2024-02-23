FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y

RUN apt install -y nginx

EXPOSE 443

# COPY conf/script.sh .

# RUN chmod +x script.sh

COPY conf/nginx.conf /etc/nginx/conf.d/

CMD ["nginx", "-g", "daemon off;"]
