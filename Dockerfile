FROM ubuntu:14.04.1
MAINTAINER Manuel Durán Aguete "manuel@aguete.org"

#Ports
# influxdb management UI
EXPOSE 8083
# influxdb API
EXPOSE 8086
#Influxdb graphite compat
EXPOSE 2003


RUN apt-get -yqq update && apt-get -yqq upgrade
RUN apt-get install -y wget curl supervisor

# Install influxdb and setup script
RUN wget http://s3.amazonaws.com/influxdb/influxdb_latest_amd64.deb
RUN dpkg -i influxdb_latest_amd64.deb
ADD influxdb/config.toml /opt/influxdb/shared/config.toml
ADD influxdb/setup.sh  /tmp/setup.sh
RUN /tmp/setup.sh

ADD supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]