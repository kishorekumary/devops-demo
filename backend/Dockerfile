FROM openjdk:11
EXPOSE 9001
ADD target/springboot-backend-0.0.1-SNAPSHOT.jar webapp.jar 
ENTRYPOINT [ "java", "-jar", "webapp.jar" ]
