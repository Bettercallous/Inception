FROM debian:bullseye

RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y nginx

CMD ["nginx", "-g", "daemon off;"]
