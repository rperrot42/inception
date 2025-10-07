OS := $(shell uname)
ifeq ($(OS), Linux)
	DOCKER_COMPOSE = docker compose
else
	DOCKER_COMPOSE = docker-compose
endif


all:
	$(DOCKER_COMPOSE) -f ./srcs/docker-compose.yml up --build -d


clean:
	$(DOCKER_COMPOSE) -f srcs/docker-compose.yml down

fclean: clean
	docker rmi nginx wordpress mariadb || true
	docker volume prune -f
	docker system prune -f

re: fclean all

.PHONY: all clean fclean re