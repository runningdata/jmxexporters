FROM maven:3-ibmjava-8-alpine as jar_builder
RUN echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories && apk update && apk upgrade && \
    apk add --no-cache bash git && git clone https://github.com/prometheus/jmx_exporter.git && cd jmx_exporter && mvn package 














FROM java:openjdk-8-jre-alpine
MAINTAINER  Will Chen <willcup@163.com>
RUN echo "http://mirrors.aliyun.com/alpine/v3.4/main/" > /etc/apk/repositories && apk update && apk upgrade && \
    apk add --no-cache bash
COPY /kafka_sample.yaml .
COPY /zookeeper_sample.yaml .
COPY /flume_sample.yaml .
COPY --from=jar_builder /jmx_exporter/jmx_prometheus_httpserver/target/jmx_prometheus_httpserver-0.11-SNAPSHOT-jar-with-dependencies.jar /jmx_prometheus_httpserver.jar
COPY /entrypoint.sh .
ENTRYPOINT ["sh", "entrypoint.sh"]
