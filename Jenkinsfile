pipeline {
    agent { label 'proj-4' }
    stages {
            stage('CHECKOUT THE SOURCE CODE OF emp-project') {
                steps {
                    dir('/home/proj-4/emp-project'){
                        git branch: 'develop', 
                        credentialsId: 'kishore-gitlab-credentials',
                        url: 'http://gitlab.zymrinc.com/ZDevOps/devops-proj-4.git'
                    }
                }
            }
           
            stage('Modify the code to make it work on this VM') {
                steps {
                    dir('/home/proj-4/emp-project'){
                       sh "sed -i 's/localhost/20.20.4.34/g' backend/src/main/java/net/javaguides/springboot/controller/EmployeeController.java"
                       sh "sed -i 's/localhost/20.20.4.34/g' frontend/src/services/EmployeeService.js"
                       echo "Done with the Code changes !!"
                    }
                }
            }
                    
            stage('Build the Application') {
                steps {
                    dir('/home/proj-4/emp-project'){
                       echo 'Start the docker build'                  
                       sh 'docker-compose build'
                       echo "Build Successful!"
                    }
                }
            }
                       
            stage('Start the application') {
                steps {
                    dir('/home/proj-4/emp-project'){
                       echo 'Going Down!'
                       sh 'docker-compose down'
                       sh 'docker-compose up -d'
                       echo 'Application Started !!!'
                    }
                }
            }
           
            stage('Sonarqube Scanning') {
                
                steps {
                    echo "Send for Sonarqube analysis !!"
                }
            }
           
            stage('Push to nexus registry ') {
                steps {
                    dir('/home/proj-4/emp-project'){
                        echo 'Pushing Artifacts to Nexus Registry!'
                    }
                }
            }
           
            stage('K8s deployment ') {
                steps {
                    dir('/home/proj-4/emp-project'){
                       echo 'Deploying on K8s !!'
                    }
                }
            }
        
        }
   }
            