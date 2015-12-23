root=$(shell pwd)
py3=$(shell which python3)
cont=flask_shell
img=redmoses/flaskshell

dev-init:
	virtualenv -p $(py3) .env; \
	$(root)/.env/bin/pip install flask

build:
	docker build -t flaskshell .

start:
	docker rm $(cont); mkdir logs; \
	docker run -p 5000:5000 --name $(cont) \
	-v $(root)/src:/app/flaskshell/src \
	-v $(root)/config:/app/flaskshell/config \
	-v $(root)/logs:/app/flaskshell/logs \
	-d $(img)

stop:
	docker stop $(cont)

restart:
	docker restart $(cont)
