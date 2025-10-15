include srcs/.env

SECRET_DIR = .SECRETS

CERT_FILE = $(SECRET_DIR)/certificate.crt
KEY_FILE = $(SECRET_DIR)/private_key.key
DOMAIN = $(LOGIN).42.fr

OS := $(shell uname)

ifeq ($(OS), Linux)
	DOCKER_COMPOSE = docker compose
else
	DOCKER_COMPOSE = docker-compose
endif

all: $(SECRET_DIR)
	mkdir -p /home/rperrot/data/mariadb
	mkdir -p /home/rperrot/data/wordpress
	$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yml up --build -d

clean:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down

fclean: clean
	docker rmi srcs-nginx srcs-mariadb srcs-wordpress || true
	docker volume prune -f
	docker system prune -f
	#sudo rm -rf /home/$(LOGIN)/data

re: fclean all

.PHONY: all clean fclean re

$(SECRET_DIR):
	mkdir -p $(SECRET_DIR)
	openssl req -x509 \
		-newkey rsa:2048 \
		-keyout $(KEY_FILE) -out $(CERT_FILE) \
		-days 365 -nodes \
		-subj "/C=FR/ST=ARA/L=Lyon/O=42Lyon/OU=IT/CN=$(DOMAIN)"