pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'susindraa/node-docker-api:latest'
        REMOTE_SERVER = 'your-server-ip'  // IP of your remote server
        REMOTE_USER = 'your-ssh-username' // SSH username
        SSH_KEY = credentials('your-ssh-key') // Jenkins credentials ID for SSH private key
    }

    stages {
        stage('Clone Repository') {
            steps {
                // If you need to pull from a Git repository, use this
                git 'https://your-repository-url.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image (if you haven't built it before)
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Login to Docker Hub (make sure to add Docker credentials in Jenkins)
                    docker.withRegistry('', 'dockerhub-credentials-id') {
                        sh 'docker push $DOCKER_IMAGE'
                    }
                }
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                script {
                    // Deploy the image on remote server via SSH
                    sshagent([SSH_KEY]) {
                        sh """
                            ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_SERVER << EOF
                                docker pull $DOCKER_IMAGE
                                docker stop $(docker ps -q --filter "name=node-docker-api") || true
                                docker rm $(docker ps -aq --filter "name=node-docker-api") || true
                                docker run -d --name node-docker-api -p 80:3000 $DOCKER_IMAGE
                            EOF
                        """
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Deployment succeeded!"
        }
        failure {
            echo "Deployment failed!"
        }
    }
}

