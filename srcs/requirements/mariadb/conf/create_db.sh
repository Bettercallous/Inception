#!bin/bash

#db_name = Database Name
#db_user = User
#db_pwd = User Password

echo "CREATE DATABASE IF NOT EXISTS wordpress ;" > db1.sql
echo "CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppass' ;" >> db1.sql
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%' ;" >> db1.sql
echo "FLUSH PRIVILEGES;" >> db1.sql

mysql < db1.sql

mysqld_safe