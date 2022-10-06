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
            
                            stage('Email-Notify') {
                            steps {
                                script {
                                    def mailRecipients = 'kishore.kumar@zymr.com'
                                    def jobName = currentBuild.fullDisplayName
                                    //emailext body: '''${SCRIPT, template="groovy-html.template"}''',
                                    emailext body: '''Please Approve the Deployment By visiting ${BUILD_URL}''',
                                        mimeTye: 'text/html',
                                        subject: "[Jenkins- ${jobName}] Approve the Deployment On Production ",
                                        to: "${mailRecipients}",
                                        replyTo: "$DEFAULT_REPLYTO"
                                    }
                                }
                             }

                    stage('Waiting for Approval') {
                        steps {
                            input("Do you wish to Approve the prod deployment ?")
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

          post{
        always{
            slackSend( channel: "#devops-projects", token: "Slack-Token", color: "good", message: "Project-4 Successfully Built !")
        }
    }
   }