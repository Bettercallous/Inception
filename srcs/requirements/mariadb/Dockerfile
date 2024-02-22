# Use Debian as the base image
FROM debian:bullseye

# Update package manager
RUN apt-get update -y

# Install MariaDB Server
RUN apt-get install -y mariadb-server

# Change bind-address to allow connections from any network
# RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# Initialize MySQL service
RUN service mariadb start
# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Copy the database initialization script from the host into the container
COPY conf/create_db.sh .

# Execute database initialization script
RUN chmod +x create_db.sh

# Expose the default MySQL port
EXPOSE 3306

# Start MariaDB service
CMD ["/create_db.sh"]
