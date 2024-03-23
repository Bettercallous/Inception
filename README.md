
<h1 align="center">
	Inception :whale2:
</h1>

<p align="center">
<b><i>A System Administration-Related Project</i></b><br>
</p>

<p align="center">
	<img alt="GitHub code size in bytes" src="https://img.shields.io/github/languages/code-size/Bettercallous/Inception?color=red" />
	<img alt="Code language count" src="https://img.shields.io/github/languages/count/Bettercallous/Inception?color=green" />
	<img alt="GitHub top language" src="https://img.shields.io/github/languages/top/Bettercallous/Inception?color=blue" />
</p>

---

## 💡 About the project :

<p align="center">
The goal of this project is to set up a small infrastructure with docker, following specific rules, which consists of three services: <br>
	MariaDB, WordPress, and Nginx.
</p>

<p align="center" width="100%">
  <img src="/readme images/diagram" width="550" height="473" />
</p>

---

## Table of contents
  [**∙ How to use ?**](#how-to-use)

  [**∙ What is Docker ?**](#what-is-docker)

  [**∙ What is a container ?**](#what-is-a-container)

  [**∙ What is Docker Compose ?**](#docker-compose)

  [**∙ What are Docker Volumes ?**](#docker-volumes)

  [**∙ What are Docker Networks ?**](#docker-networks)

  [**∙ How does Docker work ?**](#how-docker-works)

  [**∙ Containers VS Virtual Machines**](#containers-vs-vms)

  [**∙ What is MariaDB ?**](#mariadb)

  [**∙ What is WordPress ?**](#wordpress)

  [**∙ What is NGINX ?**](#nginx)

  [**∙ Resources**](#resources)

---

## How to use ?<a name="how-to-use"></a>
* **Prerequisites :** Before diving in, you'll need to ensure you have the following prerequisites installed on your system: <br>

	\- [**Make**](https://www.gnu.org/software/make/) <br>
	\- [**Docker**](https://docs.docker.com/engine/install/) <br>
	\- [**Docker Compose**](https://docs.docker.com/compose/install/) <br>

1. Clone the repository :

```bash
$ git clone git@github.com:Bettercallous/Inception.git
```

2. Enter the folder and run make :

```bash
$ cd Inception
$ make
```

❗ Be sure to fill in all the blanks in the .env.example file, and then change its name to .env

❗ You'll also need a self-signed certificate since Nginx does require an SSL certificate to establish an HTTPS connection. You can make your own one for testing with a tool called mkcert. It's really easy, just follow the steps on their github repo: **https://github.com/FiloSottile/mkcert**

---

## What is Docker ? <a name="what-is-docker"></a>
Docker is a popular containerization technology that makes it easier to create, manage, and deploy containers. (Containerization technology existed in Linux before Docker, but Docker made it more user-friendly and streamlined the process) It is built on top of existing Linux technologies such as namespaces and cgroups, which are used to provide an isolated and controlled environment for running processes, while also ensuring that resource usage is limited and controlled.<br>
Overall, Docker provides a powerful and flexible tool for building, deploying, and managing containerized applications across different platforms and environments.

## What is a Container ? <a name="what-is-a-container"></a>
A container is a standardized unit of software that packages up code and all its dependencies so that the application can run reliably and consistently on any computing environment. Containers provide a lightweight, isolated environment for running applications, where they can share the same operating system *`kernel`* but have their own filesystem, processes, and networking. They offer a portable and consistent way to package, distribute, and run software across different environments, from development laptops to production servers and cloud platforms.
* The **Kernel** is a core component of an OS and serves as the main interface between the computer’s physical hardware and the processes running on it. The kernel enables multiple applications to share hardware resources by providing access to CPU, memory, disk I/O, and networking.

## Building a Docker Container <a name="building-docker-container"></a>
Building a container with Docker typically involves creating a *`Dockerfile`*, which specifies the base image, environment configurations, dependencies, and commands needed to set up the containerized application. Example: <br>
```Dockerfile
FROM debian:bullseye

RUN apt-get update -y && apt-get install -y mariadb-server && \
    sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' \
    /etc/mysql/mariadb.conf.d/50-server.cnf

COPY conf/create_db.sh .

RUN chmod +x create_db.sh

CMD ["./create_db.sh"]
```

Once the Dockerfile is created, it is used to build the *`Docker image`* using the docker build command : <br>
```bash
# docker build -t your_image_name:tag path_to_dockerfile_directory
docker build -t mariadb .
```
which executes the instructions in the Dockerfile and packages the application and its dependencies into a portable image. During the build process, Docker pulls necessary layers from Docker Hub or a specified *`registry`*, caches layers to optimize subsequent builds, and produces a final image. This image can then be run as a *`container`* using the docker run command providing isolation and reproducibility across different environments. <br>

```bash
# docker run --name container_name image_name
docker run --name mariadb mariadb
```

* **Dockerfile** is a simple text file with instructions on how to build your image.

* **Docker Image** is an executable package that includes everything the application needs to run, including the code, runtime environment, system tools, libraries, and dependencies.
Docker images are the read-only binary templates used to create Docker Containers. <br>

* **Docker Containers** are the structural units of Docker, which is used to hold the entire package that is needed to run the application.
In other words, we can say that the image is a template, and the container is a copy of that template.

* **Docker Registry:** All the docker images are stored in the docker registry. There is a public registry which is known as a docker hub that can be used by anyone. We can run our private registry also. With the help of docker run or docker pull commands, we can pull the required images from our configured registry. Images are pushed into configured registry with the help of the docker push command.

## What is Docker Compose ? <a name="docker-compose"></a>
Docker Compose simplifies the handling of multi-container Docker apps. Using a single YAML file called docker-compose.yml, you define all services, networks, and volumes required for your app. Just run **`docker-compose up`** to start everything effortlessly. This makes managing complex apps a breeze, as you can handle them all with one command.

A Docker Compose has 3 important parts, which are:

* **Services:** Services in Docker Compose define units of work, each encapsulating one or more containers. They specify container images, environment variables, exposed ports, and additional configurations like volumes, network aliases, and health checks. When docker-compose up is run, Docker Compose creates and starts containers for each service, ensuring correct dependency order and initialization of volumes and networks.

* **Networks:** Networks provide communication channels between containers in Docker Compose. Declaring a network in the Compose file creates a new network to which all containers are connected. This allows containers to communicate using service names as hostnames, simplifying connectivity without relying on specific IP addresses.

* **Volumes:** Volumes store data shared between containers in Docker Compose. Declaring a volume in the Compose file creates a new volume accessible to all containers. This facilitates data sharing without needing to copy-paste data between containers. Volumes play a critical role in persisting data even if containers are stopped or removed, enhancing data management and portability. They can be host-mounted or named volumes, providing flexibility and portability options.

Here is an example of a docker-compose.yml file :

```yml
version: '3.8'

services:
    mariadb:
        container_name: mariadb
        build: ./requirements/mariadb/.
        init: true
        env_file:
            - .env
        networks:
            - inception
        volumes:
            - mdb-vol:/var/lib/mysql
        restart: always

    nginx:
        container_name: nginx
        build: ./requirements/nginx/.
        init: true
        ports:
            - "443:443"
        depends_on:
            - wordpress
        env_file:
            - .env
        networks:
            - inception
        volumes:
            - wp-vol:/var/www/html
        restart: always
  
    wordpress:
        container_name: wordpress
        build: ./requirements/wordpress/.
        init: true
        depends_on:
            - mariadb
        networks:
            - inception
        volumes:
            - wp-vol:/var/www/html
        env_file:
            - .env
        restart: always

networks:
    inception:
        name: inception

volumes:
    mdb-vol:
        name: mdb-vol
        driver: local
        driver_opts:
            device: /home/${USER}/data/mariadb
            o: bind
            type: none
    wp-vol:
        name: wp-vol
        driver: local
        driver_opts:
            device: /home/${USER}/data/wordpress
            o: bind
            type: none
```

* `container_name` Specifies the name of the container.
* `build` Specifies the path to the directory containing the Dockerfile used to build the image.
* `init` Run an init process in the container, which can help with proper initialization and cleanup.
* `ports` pecifies port mapping to expose ports from the container to the host system.
* `depends_on` Specifies the services that must be started before this service.
* `env_file` Specifies the path to one or more files containing environment variables.
* `networks` Specifies the networks to which the container should be connected.
* `volumes` Defines volumes to mount into the container.
* `restart` Specifies the restart policy for the container.

## What are Docker Volumes ? <a name="docker-volumes"></a>
Docker volumes are a way to persist and share data between containers and the host machine. They provide a mechanism for storing and managing data separate from the container's filesystem, ensuring that data persists even if the container is stopped or removed. Volumes solve several key problems in containerized environments such as:

* **Data Persistence:**
Containers are ephemeral by nature, meaning that any data stored within the container's filesystem is lost when the container is removed or recreated. Volumes allow you to persist data beyond the lifecycle of the container, ensuring that important data, such as database files or application logs, remains intact.

* **Data Sharing:**
Volumes enable multiple containers to share data, facilitating communication and collaboration between services within a Dockerized application. By mounting the same volume into multiple containers, you can share files, configuration settings, or other resources, streamlining development, testing, and deployment workflows.

<p align="center" width="100%">
  <img src="/readme images/docker-volumes.png" width="600"/>
</p>

Docker introduces 2 types of volumes:

* **Bind mount:** A bind mount is a file or directory on the host machine that is mounted into a container. Any changes made to the bind mount are reflected on the host machine and in any other containers that mount the same file or directory.

* **Named volume:** A named volume is a managed volume that is created and managed by Docker. It is stored in a specific location on the host machine, and it is not tied to a specific file or directory on the host. Named volumes are useful for storing data that needs to be shared between containers, as they can be easily attached and detached from containers.

You can create and manage volumes using the `docker volume` command. For example, to create a new named volume, you'd use the following command:

```
docker volume create my-volume
```

## What are Docker Networks ? <a name="docker-networks"></a>

In Docker, a network acts as a virtual space where containers reside and interact. It's akin to a digital neighborhood, allowing them to talk to each other and the outside world while providing an extra layer of organization.

Here are the primary types of networks in Docker:

* **Bridge:** This default setup allows containers to communicate internally and with the host computer. However, it restricts their access to the broader internet.
* **Host:** This network shares the host machine's network configuration with the containers, essentially making them part of the same network as the host.
* **Overlay:** Designed for distributed setups, this network connects containers across different machines, enabling seamless communication.
* **Macvlan:** Each container within this network receives its own unique IP address, resembling houses on a street within the same neighborhood.

Additionally, there's the "None" network:

* **None:** In this configuration, containers are isolated from all networks. They cannot communicate with other containers or the external world. This setup is useful for scenarios where absolute network isolation is required.

<p align="center" width="100%">
  <img src="/readme images/docker-networks.png" width="600" />
</p>

You can create and manage these networks using straightforward commands in Docker. For instance, to establish a new bridge network, you'd execute:

```bash
docker network create my-network
```

* More information about docker networks : https://youtu.be/bKFMS5C4CG0

## How does Docker work ? <a name="how-docker-works"></a>
Docker operates through a client-server architecture where the ***`docker client`*** interacts with the ***`docker daemon`*** running on the ***`docker host`*** to execute commands. The Docker daemon is responsible for managing various aspects of containerization including containers, images, networks, and volumes on the host system. ***`Docker engine`*** integrates both the Docker daemon and the ***`container runtime`***, forming a comprehensive platform for container management. When commands are issued by the Docker client, they are translated into actions executed by the Docker daemon, which then communicates with the container runtime to handle the execution and management of containers. Thus, Docker Host provides the runtime environment for containers, administered by the Docker daemon, while the Docker client serves as the interface for user interaction. Docker Engine encapsulates both the Docker daemon and the container runtime, streamlining the containerization process. <br>

* **Docker Client:** The Docker client is a command-line interface (CLI) tool that allows users to interact with the Docker daemon. It sends commands to the Docker daemon, which then executes them on the Docker host. Users can use the Docker client to build, manage, and deploy containers.

* **Docker Daemon:** The Docker daemon (dockerd) is a background process that runs on the Docker host. It is responsible for managing Docker objects such as containers, images, networks, and volumes. The daemon listens for Docker API requests from the Docker client and performs the requested actions, such as starting or stopping containers.

* **Docker Host:** This refers to the physical or virtual machine where Docker containers are deployed and run. The Docker host runs the Docker daemon, which manages the containers and provides the necessary runtime environment for them to operate.

* **Docker Engine:** Docker Engine is a term often used interchangeably with Docker daemon. It encompasses both the Docker daemon (dockerd) and the container runtime (containerd), which is responsible for managing the lifecycle of containers. Docker Engine provides an environment for developing, deploying, and running containerized applications.

* **Containerd (container runtime):** A container runtime is responsible for executing and managing containers on a host system. It's the component that handles low-level operations related to containers, such as creating, running, pausing, and deleting them.

<p align="center" width="100%">
  <img src="/readme images/Architecture-of-Docker.png" width="700"/>
</p>

## Containers VS Virtual Machines <a name="containers-vs-vms"></a>

Containers and virtual machines (VMs) are both technologies used for deploying and running applications, but they differ significantly in their approach and architecture.

Virtual machines simulate a complete hardware environment, including a guest operating system, on top of a physical host. Each VM runs its own OS instance, making them heavy in terms of resource consumption. This isolation provides strong security boundaries between VMs, but it also means that VMs have slower startup times and higher overhead.

On the other hand, containers offer a lightweight alternative. They encapsulate an application and its dependencies within a single package, sharing the host system's kernel. This shared kernel makes containers highly efficient in terms of resource usage, with minimal overhead and fast startup times. However, because containers share the host's kernel, they provide less isolation than VMs, which can lead to security concerns.

<p align="center" width="100%">
  <img src="/readme images/containers-vs-vms.png" width="600"/>
</p>

The pros of virtual machines include **`strong isolation`**, making them suitable for running multiple applications with different OS requirements on the same physical hardware. They also provide **`excellent security`** boundaries between applications. However, VMs tend to be **`resource-intensive`** and have **`slower startup times`** compared to containers.

On the other hand, containers excel in **`resource efficiency and agility`**. They allow for **`rapid deployment and scaling of applications`**, making them ideal for modern, microservices-based architectures. Containers also promote **`consistency across different environments`**, from development to production. However, the lighter isolation can potentially introduce **`security risks`**, especially if not properly managed.

In summary, virtual machines offer strong isolation and security but with higher resource overhead, while containers provide lightweight and agile deployment options but with less isolation. The choice between them depends on factors such as application requirements, resource constraints, and security considerations.

---

# MANDATORY PART
## MariaDB <a name="mariadb"></a>
* MariaDB is an open-source relational database management system (RDBMS) derived from MySQL. It provides a structured environment for storing and organizing data using tables, rows, and columns, following the relational model. As a database server, MariaDB uses Structured Query Language (SQL) for querying and manipulating data.


* Think of it as a virtual organizer for your computer files, but instead of folders and documents, it sorts and stores data for programs to use. It's like a digital librarian ensuring your information stays safe, reliable, and easily accessible. Whether it's keeping track of lots of data or quickly finding what's needed, MariaDB makes it all happen smoothly and securely.

* We're going to use MariaDB to hold our WordPress information. Without this database, WordPress won't be able to keep or find any content.

~ **Dockefile example :**

```Dockerfile
# Pull the Debian Bullseye image as the base image
FROM debian:bullseye

# Update package lists and install MariaDB server
RUN apt-get update -y && apt-get install -y mariadb-server && \

# Modify the MariaDB configuration to allow remote connections, as we will be connecting to our database from the WordPress container.
RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the shell script for creating the database
COPY conf/create_db.sh .

# Give execute permissions to the shell script
RUN chmod +x create_db.sh

# Set the default command to execute the shell script when the container starts
CMD ["./create_db.sh"]
```

~ **Database creation script :**

```bash
#!/bin/bash

service mariadb start

mariadb -e "CREATE DATABASE IF NOT EXISTS $DB_NAME ;"
mariadb -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASS' ;"
mariadb -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' ;"
mariadb -e "FLUSH PRIVILEGES;"

# mariadb : command-line client for MariaDB. It provides a way to execute SQL queries, manage databases, users, and perform various administrative tasks. 
# -e : stands for "execute." It allows you to specify a single SQL statement to be executed by MariaDB immediately after connecting.

service mariadb stop

mysqld_safe

# Using mysqld_safe is a common practice in Docker containers to ensure that the MariaDB server starts reliably and remains running within the container environment, providing a stable database service for applications running inside the container.

```

## WordPress <a name="wordpress"></a>
WordPress is a content management system that simplifies website creation, it's like a big box of LEGO bricks for making websites. You pick and choose different parts (called "themes" and "plugins") to create your site. You can write and publish articles, showcase your photos, sell stuff online, and lots more. It's super popular because it's free, easy to use, and you can customize it however you like without needing to know a bunch of complicated code.

~ **Dockerfile example :**

```bash
# Pulling our base image
FROM debian:bullseye

# Install PHP-FPM and MySQL extensions
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install php-fpm php7.4-mysqlnd -y \
    && apt-get install curl -y

# Copy the shell script for our WordPress configuration
COPY ./conf/wp-config-create.sh .

# Give execute permissions to the shell script
RUN chmod +x wp-config-create.sh

# Set the default command to execute the shell script when the container starts
CMD ["/wp-config-create.sh"]

```

~ **We install and configure WordPress in our script :**

```bash
#!/bin/bash

# Create necessary directories for WordPress installation
mkdir /var/www/
mkdir /var/www/html

# /var/www/ is typically the default location where web server software like Apache or Nginx serves website content from.

cd /var/www/html

# remove existing files from volume if there are any to install it again
rm -rf /var/www/html/*

# Download WP-CLI for managing WordPress installations
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

chmod +x wp-cli.phar 

# Move WP-CLI to the bin directory for global access, in order to use `wp` instead of `php wp-cli.phar`
mv wp-cli.phar /usr/local/bin/wp

# Download the WordPress core files
wp core download --allow-root

# Rename the sample configuration file and replace placeholders with actual database credentials, to connect with our database
mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
sed -i "s/database_name_here/$DB_NAME/" wp-config.php
sed -i "s/username_here/$DB_USER/" wp-config.php
sed -i "s/password_here/$DB_PASS/" wp-config.php
sed -i "s/localhost/$DB_HOST/" wp-config.php

# Install WordPress with provided settings
wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# Create a new user with author role
wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root

# Install and activate the Astra theme
wp theme install astra --activate --allow-root

# Update PHP-FPM configuration to listen on port 9000
sed -i 's/listen = \/run\/php\/php7.4-fpm.sock/listen = 9000/' /etc/php/7.4/fpm/.poold/www.conf

# Create directory for PHP socket file
mkdir /run/php

# Start PHP-FPM service in the foreground
php-fpm7.4 -F
```

**What is WP-CLI ?**
* WP-CLI is the command line interface for WordPress. It is a tool that allows you to interact with your WordPress site from the command line, it is used for a lot of purposes, such as automating tasks, debugging problems, installing/removing plugins alongside themes, managing users and roles, exporting/importing data, run database queries, and so much more...

**What is FastCGI ?**
* FastCGI is a variation of the Common Gateway Interface (CGI) that addresses the performance and scalability limitations of traditional CGI. It is a protocol that allows web servers to communicate with external application processes efficiently, enabling dynamic content generation for web applications. With traditional CGI, a new process is spawned for each request, leading to a significant performance overhead. FastCGI improves upon this by introducing a persistent application process pool that remains alive even after processing a request. This process pool eliminates the need to start a new process for each incoming request, reducing the overhead and providing better performance and resource utilization.

**What is PHP-FPM ?**
* PHP-FPM (FastCGI Process Manager) is an implementation of the FastCGI protocol specifically designed for use with PHP. It works by starting a pool of worker processes that are responsible for executing PHP scripts. When a web server receives a request for a PHP script, it passes the request to one of the worker processes, which then executes the script and returns the result to the web server. This allows PHP scripts to be executed more efficiently, as the worker processes can be reused for multiple requests.

**So basically, when your web server (Nginx) receives a request for a static file, like an image or HTML document, it delivers it directly. However, for dynamic content generated on-the-fly (like WordPress posts in this case), Nginx needs to hand off the request to another program (PHP-FastCGI Process Manager or PHP-FPM) for processing. This communication happens through FastCGI protocol.**

## NGINX <a name="nginx"></a>
NGINX is a free and open-source web server software known for its speed and efficiency. It acts as the middleman between your website and the internet, delivering web pages to users just like a traffic cop directing visitors. Unlike basic servers, NGINX goes beyond serving content. It excels at caching frequently accessed files, reducing load times, and even balancing traffic across multiple servers to ensure smooth performance for all visitors.

~ **Dockerfile example :**
```bash
# Pull our base image
FROM debian:bullseye

# Install nginx
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y nginx

# Copy our nginx config file to conf.d folder inside the container
COPY conf/nginx.conf /etc/nginx/conf.d

# Run nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
```

~ **nginx.conf :**

```bash
server {

  # Listen on port 443 with SSL encryption
  listen 443 ssl;

  # Server name (hostname) for this configuration
  server_name login.42.fr;

  # Path to the SSL certificate file
  ssl_certificate /etc/nginx/ssl/login.42.fr.crt;

  # Path to the SSL private key file
  ssl_certificate_key /etc/nginx/ssl/login.42.fr.key;

  # Supported SSL/TLS protocols
  ssl_protocols TLSv1.2 TLSv1.3;

  # Default index file to serve
  index index.php;

  # The root directory that should be used to search for files
  root /var/www/html;

  # Location block for handling PHP requests
  location ~ \.php$ {

    # Try to serve the requested PHP file directly, otherwise return 404 (Not Found)
    try_files $uri = 404;

    # Pass PHP requests to a FastCGI server (e.g., PHP-FPM) listening on port 9000 of the "wordpress" service
    fastcgi_pass wordpress:9000;

    # Include FastCGI parameters necessary for passing PHP requests
    include fastcgi_params;

    # Set the SCRIPT_FILENAME variable for PHP scripts based on document root and requested URI
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
  }
}

```
**What is SSL ?**
* SSL, more commonly called TLS, is a protocol for encrypting Internet traffic and verifying server identity. Any website with an HTTPS web address uses SSL/TLS. Imagine it as a secret tunnel between your web browser and a website.

* SSL was first developed by Netscape in 1995 for the purpose of ensuring privacy, authentication, and data integrity in Internet communications. SSL is the predecessor to the modern TLS encryption used today.

* A website that implements SSL/TLS has "HTTPS" in its URL instead of "HTTP."

<br>
<p align="center" width="100%">
  <img src="/readme images/http-vs-https.png" width="500"/>
</p>
<br>

**How does SSL/TLS work ?**
* In order to provide a high degree of privacy, SSL encrypts data that is transmitted across the web. This means that anyone who tries to intercept this data will only see a garbled mix of characters that is nearly impossible to decrypt.

* SSL initiates an authentication process called a [**handshake**](https://youtu.be/AlE5X1NlHgg?list=PLBOAJ-0d96X7jxk-ulTQpqz5AzXYagiSK) between two communicating devices to ensure that both devices are really who they claim to be.

* SSL also digitally signs data in order to provide data integrity, verifying that the data is not tampered with before reaching its intended recipient.

**What is an SSL Certificate ?**
* SSL certificates are what enable websites to use HTTPS, which is more secure than HTTP. An SSL certificate is a data file hosted in a website's origin server. SSL certificates make SSL/TLS encryption possible, and they contain the website's public key and the website's identity, along with related information.

* Devices attempting to communicate with the origin server will reference this file to obtain the public key and verify the server's identity. The private key is kept secret and secure.

---

### :link: Resources : <a name="resources"></a>
* **Docker docs: - https://docs.docker.com/guides/get-started/**
* **Docker crash course: - https://www.youtube.com/playlist?list=PL4cUxeGkcC9hxjeEtdHFNYMtCpjNBm3h7**
* **Article about Docker: - https://medium.com/@kmdkhadeer/docker-get-started-9aa7ee662cea**
* **Docker Networking: - https://youtu.be/bKFMS5C4CG0?list=PLBOAJ-0d96X7jxk-ulTQpqz5AzXYagiSK**
* **Best practices for building containers: - [**cloud.google.com**](https://cloud.google.com/architecture/best-practices-for-building-containers)**
* **The Compose Specification: - https://github.com/compose-spec/compose-spec/blob/master/spec.md**
* **CGI FastCGI and PHP-FPM: - [**medium.com**](https://medium.com/@miladev95/cgi-vs-fastcgi-vs-php-fpm-afbc5a886d6d#:~:text=FastCGI%20improves%20upon%20CGI%20by,security%20for%20serving%20PHP%20applications)**
* **SSL: - https://www.cloudflare.com/learning/ssl/what-is-ssl/**
* **TLSv1.2 and TLSv1.3: - https://youtu.be/AlE5X1NlHgg?list=PLBOAJ-0d96X7jxk-ulTQpqz5AzXYagiSK**
* **Init process: [medium.com](https://medium.com/@BeNitinAgarwal/an-init-system-inside-the-docker-container-3821ee233f4b) - [www.padok.fr](https://www.padok.fr/en/blog/docker-processes-container)**
---
