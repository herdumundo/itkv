#!/bin/sh
mvn clean package && docker build -t com.maehara/itkv .
docker rm -f itkv || true && docker run -d -p 9080:9080 -p 9443:9443 --name itkv com.maehara/itkv