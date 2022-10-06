#Get the official image from dockerhub
FROM mysql:5.7
#Copy init.sql to initiate database "employee_management_system"
RUN groupadd -r -g 2000 javauser && useradd -u 2000 -r -g javauser javauser
RUN chown -R javauser:javauser /docker-entrypoint-initdb.d /var/lib/mysql
USER javauser

COPY init.sql /docker-entrypoint-initdb.d/application/init.sql
