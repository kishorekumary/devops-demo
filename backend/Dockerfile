#Stage-1

#Pull the official image
 FROM maven:3.8.6-jdk-11 AS build
 #set the working Directory
 WORKDIR /usr/src/app
 #copy pom.xml to the working directory
 COPY pom.xml .
#copy everything in src folder
 COPY src /usr/src/app/src
 RUN mvn -f /usr/src/app/pom.xml clean package

#Stage-2 

#Pull the official image
 FROM openjdk:11
 #Copy the artifact to here from the previous stage
 COPY --from=build /usr/src/app/target/springboot-backend-0.0.1-SNAPSHOT.jar /usr/app/webapp.jar 
 #Expose 9001 to be able to connect with frontend
 EXPOSE 9001
 #Runs the background
 ENTRYPOINT ["java","-jar","/usr/app/webapp.jar"]
