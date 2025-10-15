FROM debian:bookworm

RUN apt update -y

RUN apt install php-fpm php-mysql -y

RUN apt install curl -y

RUN apt install  default-mysql-client -y
RUN apt install  netcat-openbsd -y

RUN mkdir -p /var/www/html


VOLUME ["/var/www/html"]

EXPOSE 9000

COPY tools/docker-entrypoint.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

#CMD ["mariadbd"]
CMD ["sh", "/usr/local/bin/docker-entrypoint.sh"]
