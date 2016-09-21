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

ZUULPROXY="${ZUUL_FQDN}/${MICROSERVICE_NAME}/${CONTEXT_PATH}"
echo "Zuul Proxy URL: $ZUULPROXY"
sed -e "s|\(\"baseURL\".*http:\/\/\)\(.*\)\(\/review.*\)|\1$ZUULPROXY\3|" server/datasources.json
sed -i -e "s|\(\"url\".*http:\/\/\)\(.*\)\(\/review.*\)|\1$ZUULPROXY\3|g" server/datasources.json
cat server/datasources.json|grep baseURL
