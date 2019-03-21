#!/bin/sh

docker run --rm -it -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e "http.cors.enabled=true" -e "http.cors.allow-origin=*"  docker.elastic.co/elasticsearch/elasticsearch:6.6.2