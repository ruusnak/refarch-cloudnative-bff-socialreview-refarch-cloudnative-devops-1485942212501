#!/bin/bash
 
sed -i -e "s|\(\"baseURL\".*http:\/\/\)\(.*\)\(\/micro.*\)|\1$1\3|" server/datasources.json
cat server/datasources.json|grep baseURL
