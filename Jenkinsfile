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

            stage('Email-Notify') {
                
                steps {
                    script {
                        def mailRecipients = 'kishore.kumar@zymr.com'
                        def jobName = currentBuild.fullDisplayName
                        emailext body: '''Please Approve the Deployment By visiting ${BUILD_URL}''',
                        mimeTye: 'text/html',
                        subject: "[Jenkins- ${jobName}] Approve the Deployment On Production ",
                        to: "${mailRecipients}",
                        replyTo: "${mailRecipients}"
                    }
                }
            }

            stage('Waiting for Approval') {
                steps {
                    input("Do you wish to Approve the prod deployment ?")
                }
            }
           
            stage('Publish To Nexus') {
                steps {
                       sh 'docker tag frontend:latest ykishore/frontend:$RELEASE_TAG'
                       sh 'docker tag frontend:latest ykishore/frontend:latest'
                       sh 'docker tag backend:latest ykishore/backend:$RELEASE_TAG'
                       sh 'docker tag backend:latest ykishore/backend:latest'
                       sh 'docker tag mysql-db:latest ykishore/mysql-db:$RELEASE_TAG'
                       sh 'docker tag mysql-db:latest ykishore/mysql-db:latest'                
                    withCredentials([usernamePassword(credentialsId: 'ykk-docker-credentials', passwordVariable: 'password', usernameVariable: 'username')]) {
                       sh 'docker login  -u $username -p $password'
                       sh 'docker push ykishore/frontend:$RELEASE_TAG'
                       sh 'docker push ykishore/backend:$RELEASE_TAG'
                       sh 'docker push ykishore/mysql-db:$RELEASE_TAG'
                       sh 'docker push ykishore/frontend:latest'
                       sh 'docker push ykishore/backend:latest'
                       sh 'docker push ykishore/mysql-db:latest'
                       echo 'Artifacts Published to docker Repo!'
                    }
                }
            }
           
            stage('K8s deployment ') {
                steps {
                       echo 'Deploying on K8s !!'
                       sh """envsubst < k8s/secrets.yaml|kubectl apply -f -""" 
                       sh 'kubectl apply -f k8s/mysql-storage.yaml || true'
                       sh """envsubst < k8s/configmap.yaml|kubectl apply -f -""" 
                       sh """envsubst < k8s/frontend-deploy.yaml|kubectl apply -f -""" 
                       sh """envsubst < k8s/db-deploy.yaml|kubectl apply -f - """
                       sh """envsubst < k8s/backend-deploy.yaml|kubectl apply -f - """
                }
            }
        
        }


    /*post{
        success {
            slackSend( channel: "#devops-projects", token: "Slack-Token", color: "good", message: "Project-4 at ${BUILD_URL} has deployed the latest onto the prod!")
        }
        failure {
            slackSend( channel: "#devops-projects", token: "Slack-Token", color: "good", message: "Project-4 at ${BUILD_URL} has result fail ")
        }
    }*/

}