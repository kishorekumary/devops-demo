# Employee Management 

Simple Application To CRUD Employee Information.

## Tech Stack
> React
> Spring Boot
> MySQL DB

## Pre-req
> Node JS installed (tested in 16.10.0).
> Java 8+ installed
> Mysql Server

## Build
### DB
> Create a Database eg: `employee_management_system`
> Login to the Database and execute the table query
    ```
    mysql -u <username> -p<password>
    create database employee_management_system
    ```

### Backend
> Set DB Environment Variables 
    ```
    export MYSQL_CONNECTION=localhost
    export MYSQL_DATABASE=employee_management_system
    export MYSQL_ROOT_USER=root
    export MYSQL_ROOT_PASSWORD=abcd1234
    export CORS_ALLOW_URL=http://localhost:3000
    ```
> Build the Jar file
    `mvn package`

> Deploy the Jar
    `java -jar target\springboot-backend-0.0.1-SNAPSHOT.jar`

### Frontend
> Build the Node packages
    `npm install`
> Run on the developer local
    `npm start`
> Production Bulid
    `npm run build`
> Staging Build
    `npm run build:staging`

### Dockerfile, Docker-compose and deployment should be on Kubernetes
### Also use Sonarqube
### Also use Nginx