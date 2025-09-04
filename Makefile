all:
	docker compose -f srcs/docker-compose.yml up --build -d

clean:
	docker compose -f ./srcs/docker-compose.yml down
	docker container prune -f
	docker image prune -a -f
	docker volume prune -f
	docker network prune -f

