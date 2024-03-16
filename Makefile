all: up

up:
	@docker-compose -f ./srcs/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

build:
	@docker-compose -f ./srcs/docker-compose.yml build

re:
	@docker-compose -f ./srcs/docker-compose.yml down -v
	@docker-compose -f ./srcs/docker-compose.yml up --build -d

logs:
	@docker-compose -f ./srcs/docker-compose.yml logs

clean: down
	@docker system prune --force
