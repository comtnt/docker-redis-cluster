build:
	docker build -t rediscluster .
rebuild:
	docker build --no-cache -t rediscluster .
down:
	docker-compose down
up:
	make down
	make build
	docker-compose up -d
monitor:
	docker-compose logs
run-cli:
	docker-compose exec redis-cluster redis-cli -c -p 7000
run-shell:
	docker-compose exec redis-cluster /bin/bash
stop-swarm:
	docker stack rm rediscluster
	docker swarm leave --force
start-swarm:
	make stop-swarm
	make build
	docker swarm init
	docker stack deploy -c docker-compose.yml rediscluster
push:
	make build
	docker tag rediscluster riandyrn/rediscluster:latest
	docker push riandyrn/rediscluster:latest