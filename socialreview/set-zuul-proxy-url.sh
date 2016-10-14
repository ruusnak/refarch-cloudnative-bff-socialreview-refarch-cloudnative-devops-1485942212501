#!/bin/bash

MICROSERVICE_NAME=socialreview-microservice
CONTEXT_PATH=micro

while [[ $# -gt 1 ]]
do
arg="$1"
case $arg in
    -m|--msname)
    MICROSERVICE_NAME="$2"
    shift;;
    -c|--context)
    CONTEXT_PATH="$2"
    shift;;
    -z|--zuul)
    ZUUL_FQDN=$(echo ${2}|sed -e "s/http.*\/\///" -e "s/\/$//")
    shift;;
    *)
esac
shift
done

ZUULPROXY="https://${ZUUL_FQDN}/${MICROSERVICE_NAME}/${CONTEXT_PATH}"
echo "Zuul Proxy URL: $ZUULPROXY"
sed -i -e "s|\(\"baseURL\"\)\(.*\)\(http.*\)\(\/review.*\)|\1\2$ZUULPROXY\4|" server/datasources.json >/dev/null
sed -i -e "s|\(\"url\"\)\(.*\)\(http.*\)\(\/review.*\)|\1\2$ZUULPROXY\4|g" server/datasources.json >/dev/null
cat server/datasources.json|grep baseURL
cat server/datasources.json|grep url
exit
