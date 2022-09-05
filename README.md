# Employee Management 

Simple Application To CRUD Employee Information.

## Tech Stack
1. React
2. Spring Boot
3. MySQL DB

## Pre-req
1. Node JS installed (tested in 16.10.0).
2. Java 8+ installed
3. Mysql Server

## Build
### DB
1. Create a Database eg: `employee_management_system`
2. Login to the Database and execute the table query
    `mysql -u <username> -p<password>`
    `> create database employee_management_system`

### Backend
1. Update the Following properties in `src/main/java/resources/application.properties`
    i.e: update the db details correctly
    ```
        server.port=9001
        spring.datasource.url=jdbc:mysql://localhost:3306/employee_management_system?useSSL=false
        spring.datasource.username=root
        spring.datasource.password=abcd1234

    ```
2. Build the Jar file
    `mvn package`

3. Deploy the Jar
    `java -jar target\springboot-backend-0.0.1-SNAPSHOT.jar`

### Frontend
1. update the Backend URL in `react-frontend/src/services/EmployeeService.js`
2. Build the Node packages
    `npm install`
3. Run on the developer local
    `npm start`

### Dockerfile, Docker-compose and deployment should be on Kubernetes
### Also use Sonarqube
### Also use Nginx