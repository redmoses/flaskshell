FROM ubuntu:trusty
MAINTAINER Red Moses <musa@redmoses.me>
# install packages
RUN sed -i 's/archive.ubuntu.com/mirror.dhakacom.com/g' /etc/apt/sources.list;
RUN apt-get update; apt-get install -y python3-pip supervisor; \
  pip3 install flask; mkdir -p /app/flaskshell/logs
# copy src and config directory
COPY src/ /app/flaskshell/src
COPY config/ /app/flaskshell/config/
# expose the port
EXPOSE 5000
# create entrypoint
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/app/flaskshell/config/supervisord.conf"]
