pipeline {
    agent { label 'proj-4' }
    
    stages {
            stage('Update frontend .env file !') {
                steps {
                       sh 'rm frontend/.env || true'
                       sh 'touch frontend/.env'
                       sh """ echo "REACT_APP_BACKEND_URL=${params.REACT_APP_BACKEND_URL}" >> frontend/.env """
                       echo "Updated frontend environment file !!"
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
                       sh 'docker tag frontend:latest nexus.zymrinc.com:8083/devops-proj-4/frontend:$MAJOR_VERSION.$MINOR_VERSION.$BUILD_NUMBER'
                       sh 'docker tag frontend:latest nexus.zymrinc.com:8083/devops-proj-4/frontend:latest'
                       sh 'docker tag backend:latest nexus.zymrinc.com:8083/devops-proj-4/backend:$MAJOR_VERSION.$MINOR_VERSION.$BUILD_NUMBER'
                       sh 'docker tag backend:latest nexus.zymrinc.com:8083/devops-proj-4/backend:latest'
                       sh 'docker tag mysql-db:latest nexus.zymrinc.com:8083/devops-proj-4/mysql-db:$MAJOR_VERSION.$MINOR_VERSION.$BUILD_NUMBER'
                       sh 'docker tag mysql-db:latest nexus.zymrinc.com:8083/devops-proj-4/mysql-db:latest'
                  
                    
                    withCredentials([usernamePassword(credentialsId: 'Nexus-Cred', passwordVariable: 'password', usernameVariable: 'username')]) {
                        sh 'docker login nexus.zymrinc.com:8083 -u $username -p $password'
                        sh 'docker push nexus.zymrinc.com:8083/devops-proj-4/frontend:$MAJOR_VERSION.$MINOR_VERSION.$BUILD_NUMBER'
                        sh 'docker push nexus.zymrinc.com:8083/devops-proj-4/backend:$MAJOR_VERSION.$MINOR_VERSION.$BUILD_NUMBER'
                        sh 'docker push nexus.zymrinc.com:8083/devops-proj-4/mysql-db:$MAJOR_VERSION.$MINOR_VERSION.$BUILD_NUMBER'
                        sh 'docker push nexus.zymrinc.com:8083/devops-proj-4/frontend:latest'
                        sh 'docker push nexus.zymrinc.com:8083/devops-proj-4/backend:latest'
                        sh 'docker push nexus.zymrinc.com:8083/devops-proj-4/mysql-db:latest'
                    }
                }
            }
           
            stage('K8s deployment ') {
                steps {
                       echo 'Deploying on K8s !!'
                }
            }
        
        }
   }
            