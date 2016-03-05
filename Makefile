cont=flaskshell
mysql_cont=flaskshell_mysql
nginx_cont=flaskshell_nginx

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

start:
	docker-compose start

stop:
	docker-compose stop

restart:
	docker-compose restart

shell:
	docker exec -ti $(cont) bash

shell-mysql:
	docker exec -ti $(mysql_cont) bash

shell-nginx:
	docker exec -ti $(nginx_cont) bash
