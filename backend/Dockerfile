FROM openjdk:11
EXPOSE 9001
ADD target/springboot-backend-0.0.1-SNAPSHOT.jar webapp.jar 
ENTRYPOINT [ "java", "-jar", "webapp.jar" ]


#  FROM maven:3.8.6-jdk-11 AS build
#  WORKDIR /usr/src/app
#  COPY pom.xml pom.xml
#  COPY src /usr/src/app/src
#  RUN mvn -f /usr/src/app/pom.xml clean package

 

#  FROM openjdk:11
#  COPY --from=build /usr/src/app/target/springboot-backend-0.0.1-SNAPSHOT.jar /usr/app/webapp.jar 
#  EXPOSE 9001
#  ENTRYPOINT ["java","-jar","/usr/app/webapp.jar"]