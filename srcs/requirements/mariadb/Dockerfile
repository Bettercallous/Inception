FROM debian:bullseye

RUN apt-get update -y

RUN apt-get install -y mariadb-server

# Change bind-address to allow connections from any network
RUN sed -i 's/bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

RUN service mariadb start
# RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY conf/create_db.sh .

RUN chmod +x create_db.sh

CMD ["/create_db.sh", "mysql < db1.sql"]
