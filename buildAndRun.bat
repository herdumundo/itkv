@echo off
call mvn clean package
call docker build -t com.maehara/itkv .
call docker rm -f itkv
call docker run -d -p 9080:9080 -p 9443:9443 --name itkv com.maehara/itkv