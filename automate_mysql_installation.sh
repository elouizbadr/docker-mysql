#!/bin/bash
set -e

# Download and Install the Latest Updates for the OS
apt-get update

# Set the Server Timezone to CST
echo "Africa/Casablanca" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# Enable Ubuntu Firewall and allow SSH & MySQL Ports
#ufw enable
#ufw allow 22
#ufw allow 3306

# Install essential packages
apt-get -y install zsh htop

# Install MySQL Server in a Non-Interactive mode. Default root password will be "root"
echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
apt-get -y install mysql-server

service mysql start

# Run the MySQL Secure Installation wizard
automate_mysql_secure_installation.sh root root

sed -i 's/127\.0\.0\.1/0\.0\.0\.0/g' /etc/mysql/my.cnf
mysql -uroot -proot -e 'USE mysql; UPDATE `user` SET authentication_string=PASSWORD("root"), `Host`="%" WHERE `User`="root" AND `Host`="localhost"; DELETE FROM `user` WHERE `Host` != "%" AND `User`="root"; FLUSH PRIVILEGES;'

rm -rf /var/lib/apt/lists/*

service mysql restart

/bin/bash
