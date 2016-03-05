FROM ubuntu:trusty
MAINTAINER Red Moses <musa@redmoses.me>
# create app user
RUN useradd -ms /bin/bash -d /app/flaskshell mr_app
# install system packages
RUN apt-get update; apt-get install -y python3-pip mysql-client
# copy requirements.pip
COPY config/ /app/flaskshell/config
# install python packages
RUN pip3 install -r /app/flaskshell/config/requirements.pip
# copy src directory
COPY src/ /app/flaskshell/src
# create logs directory
RUN mkdir /app/flaskshell/logs
# expose the port
EXPOSE 5000
# set workdir
WORKDIR /app/flaskshell/src
# set entrypoint
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/app/flaskshell/config/supervisord.conf"]
