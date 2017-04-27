FROM elouizbadr/ubuntu:latest
MAINTAINER elouiz.badr@gmail.com

RUN apt-get update && apt-get install -y tzdata \
 && rm -rf /var/lib/apt/lists/*

COPY automate_mysql_installation.sh /usr/local/bin/
COPY automate_mysql_secure_installation.sh /usr/local/bin/

ENTRYPOINT ["automate_mysql_installation.sh"]

EXPOSE 3306
