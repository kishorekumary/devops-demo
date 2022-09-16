pipeline {
    agent { label 'proj-4' }
    environment {
        HOST_IP = '20.20.4.34'
        }
    stages {
            stage('Update CORS & backend URLs !') {
                steps {
                  
                       sh "sed -i 's/localhost/$HOST_IP/g' backend/src/main/java/net/javaguides/springboot/controller/EmployeeController.java"
                       sh "sed -i 's/localhost/$HOST_IP/g' frontend/src/services/EmployeeService.js"
                       echo "Updated CORS URL and Backend URL !!"
                }
            }
                    
            stage('Build the Application') {
                steps {
                       echo 'Start the docker build'                  
                       sh 'docker-compose build'
                       echo "Build Successful!"
                }
            }
                       
            stage('Start the application') {
                steps {
                       sh 'docker-compose down'
                       sh 'docker-compose up -d'
                       echo 'Application Started !'
                }
            }
           
            stage('Sonarqube Scanning') {
                
                steps {
                    echo "Send for Sonarqube analysis !!"
                }
            }
           
            stage('Push to nexus registry ') {
                steps {
                       echo 'Pushing Artifacts to Nexus Registry!'
                }
            }
           
            stage('K8s deployment ') {
                steps {
                       echo 'Deploying on K8s !!'
                }
            }
        
        }
   }
            