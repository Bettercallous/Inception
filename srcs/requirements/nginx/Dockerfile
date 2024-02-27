FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
