#! /bin/bash
if [ $# != 3 ]; then
echo "Usage entrypoint.sh <hostPort> <http_port> <srv_type>"
exit 0
fi

HOST_PORT=$1
HTTP_PORT=$2
SRV_TYPE=$3

METRIC_FILE=/${SRV_TYPE}_sample.yaml

echo "hostPort: ${HOST_PORT}" >> ${METRIC_FILE}

echo "http port is ${HTTP_PORT}, target host port is ${HOST_PORT}"
java -Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.port=5555 -jar /jmx_prometheus_httpserver.jar ${HTTP_PORT} ${METRIC_FILE}  
