pipeline {
    agent { label 'proj-4' }
    
    stages {
            stage('Pre Build: Dev') {
                steps {
                       sh 'rm frontend/.env || true'
                       sh 'touch frontend/.env'
                       sh """ echo "REACT_APP_BACKEND_URL=${params.REACT_APP_BACKEND_URL}" >> frontend/.env """
                       echo "Updated frontend environment file !!"
                }
            }
                    
            stage('Build forDev') {
                steps {
                       echo 'Start the docker build'                  
                       sh 'docker-compose build'
                       echo "Build Successful!"
                }
            }
                       
            stage('Deploy To Dev') {
                steps {
                       sh 'docker-compose down'
                       sh 'docker-compose up -d'
                       echo 'Application Started !'
                }
            }
            
            stage('Pre Build: Prod') {
                steps {
                       sh 'rm frontend/.env || true'
                       sh 'touch frontend/.env'
                       sh """ echo "REACT_APP_BACKEND_URL=${params.K8S_REACT_APP_BACKEND_URL}" >> frontend/.env """
                       echo "Updated frontend environment file !!"
                }
            }

            stage('Build for Prod') {
                steps {
                       echo 'Start the docker build'                  
                       sh 'docker-compose build frontend'
                       echo "Build Successful!"
                }
            }
           
            stage('Sonarqube Scanning') {
                
                steps {
                    echo "Send for Sonarqube analysis !!"
                }
            }
           
            stage('Publish To Nexus') {
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
                       echo 'Artifacts Published to Nexus Repo!'
                    }
                }
            }
            
            stage('Test') {
                def userAborted = false
                emailext body: '''
                Please go to console output of ${BUILD_URL} input to Approve or Reject.<br>
                ''',
                mimeType: 'text/html',
                subject: "[Jenkins] ${currentBuild.fullDisplayName  } Build Approval Request",
                from: "kishore.kumar@zymr.com"
                to: "kishore.kumar@zymr.com"
                steps {
                    input("Test completed ? Please provide Approvals for Prod Release ?")
                }  
            }

            stage('K8s deployment ') {
                steps {
                       echo 'Deploying on K8s !!'
                       sh 'kubectl apply -f k8s/mysql-storage.yaml || true'
                       sh 'kubectl apply -f k8s/frontend-deploy.yaml '
                       sh """envsubst < k8s/db-deploy.yaml|kubectl apply -f - """
                       sh """envsubst < k8s/backend-deploy.yaml|kubectl apply -f - """
                       sh "docker logout nexus.zymrinc.com:8083"

                }
            }
        
        }
   }