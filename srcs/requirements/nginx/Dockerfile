FROM debian:bookworm

RUN    apt-get update
RUN    apt-get upgrade -y

RUN    apt-get install -y nginx

COPY    conf/nginx.conf /etc/nginx/nginx.conf
COPY    pages/ /usr/share/nginx/html/

EXPOSE  443

CMD     ["nginx", "-g", "daemon off;"]
