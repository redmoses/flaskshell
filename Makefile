cont=flaskshell
mysql_cont=flaskshell_mysql
nginx_cont=flaskshell_nginx
mysql_cmd=docker exec -ti $(mysql_cont) mysql -uroot -proot

build:
	docker-compose build

prepare:
	-@$(mysql_cmd) -e "DROP DATABASE flaskshell; CREATE DATABASE flaskshell;"; \
	$(mysql_cmd) -e "CREATE TABLE flaskshell.tasks (task_id INT NOT NULL AUTO_INCREMENT, task_title VARCHAR(50), task_status VARCHAR(50), PRIMARY KEY (task_id));"; \
	$(mysql_cmd) -e "INSERT INTO flaskshell.tasks (task_title, task_status) VALUES ('Task 1', 'Success');"; \
	$(mysql_cmd) -e "INSERT INTO flaskshell.tasks (task_title, task_status) VALUES ('Task 2', 'Pending');"; \
	$(mysql_cmd) -e "INSERT INTO flaskshell.tasks (task_title, task_status) VALUES ('Task 3', 'Failed');"

up:
	docker-compose up -d

wait:
	echo "Waiting for mysql to start" && sleep 10

init: up wait prepare

down:
	docker-compose down

start:
	docker-compose start

stop:
	docker-compose stop

status:
	docker-compose ps

restart:
	docker-compose restart

restart-app:
	docker exec -ti $(cont) supervisorctl restart flaskshell

shell:
	docker exec -ti $(cont) bash

shell-mysql:
	docker exec -ti $(mysql_cont) bash

shell-nginx:
	docker exec -ti $(nginx_cont) bash
