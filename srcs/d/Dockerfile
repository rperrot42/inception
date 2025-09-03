FROM debian:bookworm

RUN    apt-get update
RUN    apt-get upgrade -y

RUN  apt-get  install mariadb-server  -y
RUN  rm -rf /var/lib/apt/lists/*

#USER mysql

expose 3306

VOLUME ["/var/lib/mysql"]

# Copier les scripts de configuration
COPY docker-entrypoint.sh /usr/local/bin/
COPY my.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

CMD ["tail", "-f"]
