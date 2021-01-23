FROM alpine:3.13

ENV INFLUXDB_VERSION=1.8.3
RUN apk add --no-cache curl && \
    curl -sSfL https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}-static_linux_amd64.tar.gz | tar xz && \
    mv influxdb-*/influx influxdb-*/influx_inspect influxdb-*/influx_stress influxdb-*/influx_tsm influxdb-*/influxd /usr/local/bin && \
    rm -rf influxdb-* && \
    addgroup -S -g 924 influxdb && \
    adduser -S -D -u 924 -G influxdb -g influxdb -h /var/lib/influxdb -s /sbin/nologin influxdb

COPY influxdb.conf /etc/influxdb/influxdb.conf

EXPOSE 8086
VOLUME /var/lib/influxdb

USER influxdb
CMD ["/usr/local/bin/influxd"]
