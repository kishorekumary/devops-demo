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
            