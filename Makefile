OS := $(shell uname)
ifeq ($(OS), Linux)
	DOCKER_COMPOSE = docker compose
else
	DOCKER_COMPOSE = docker-compose
endif


all:
	$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yml up --build -d

clean:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down -v --rmi local

fclean:
ifeq ($(OS), Linux)
	rm -rf /home/rperrot/data
else
	rm -rf /Users/raphaelperrot/SynologyDrive/Documents/inception/data
endif

re: fclean all

.PHONY: all clean fclean re