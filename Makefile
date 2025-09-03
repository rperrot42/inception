all:
	docker compose -f srcs/docker-compose.yml up --build -d

clean:
	docker compose down -v