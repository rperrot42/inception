FROM debian:bookworm
 #installation de mariadb

RUN    apt-get update
RUN    apt-get upgrade -y

RUN  apt-get  install mariadb-server  -y
RUN  rm -rf /var/lib/apt/lists/*


RUN mkdir -p /var/run/mysqld

#ajout les droit pour l'utilisateur mysql pour run les droits
RUN chown mysql:mysql /var/run/mysqld
RUN mkdir -p /home/rperrot/data


expose 3306

VOLUME ["/var/lib/mysql"]

# Copier les scripts de configueration sur le docker
COPY docker-entrypoint.sh /usr/local/bin/
#copier la config de mariadb
COPY my.cnf /etc/mysql/mariadb.conf.d/99-custom.cnf

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

#CMD ["mariadbd"]
CMD ["sh", "/usr/local/bin/docker-entrypoint.sh"]
