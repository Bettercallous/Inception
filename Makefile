all: up

up:
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

build:
	@docker-compose -f ./srcs/docker-compose.yml build

start:
	@docker-compose -f ./srcs/docker-compose.yml start

stop:
	@docker-compose -f ./srcs/docker-compose.yml stop

re:
	@docker-compose -f ./srcs/docker-compose.yml down -v
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

logs:
	@docker-compose -f ./srcs/docker-compose.yml logs

clean: down
	@docker system prune --force

fclean: down
	@docker system prune --all --force
	@docker network prune --force
	@docker volume prune --force