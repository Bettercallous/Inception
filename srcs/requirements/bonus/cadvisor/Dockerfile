# Use Debian Bullseye as the base image
FROM debian:bullseye

RUN apt-get update && apt-get install -y curl

RUN curl -Lo /usr/bin/cadvisor https://github.com/google/cadvisor/releases/download/v0.40.0/cadvisor \
    && chmod +x /usr/bin/cadvisor

EXPOSE 150

CMD ["/usr/bin/cadvisor", "-port=150"]
