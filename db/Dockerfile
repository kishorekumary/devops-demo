#Get the official image from dockerhub
FROM mysql:5.7
#Copy init.sql to initiate database "employee_management_system"
COPY init.sql /docker-entrypoint-initdb.d/application/init.sql
