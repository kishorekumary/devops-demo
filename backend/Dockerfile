#Stage-1

#Pull the official image from dockerhub
 FROM maven:3.8.6-jdk-11 AS build
 #set the working Directory
 WORKDIR /usr/app
 #copy pom.xml to the working directory
 COPY pom.xml pom.xml
#copy everything in src folder
 COPY src src
 RUN mvn clean package

#Stage-2 

#Pull the official image from dockerhub
 FROM openjdk:11-jre-slim
 #Copy the artifact to here from the previous stage
 COPY --from=build /usr/app/target/springboot-backend-0.0.1-SNAPSHOT.jar /usr/app/webapp.jar 
 #Expose 9001 to be able to connect with frontend
 EXPOSE 9001
#Add Javauser 
RUN groupadd -r -g 2000 javauser && useradd -u 2000 -r -g javauser javauser
RUN chown -R javauser:javauser /usr/app
USER javauser
 #Runs the background
 ENTRYPOINT ["java","-jar","/usr/app/webapp.jar"]


