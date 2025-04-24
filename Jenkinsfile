pipeline {
    agent any

    environment {
        DOCKER_IMAGE   = 'susindraa/node-docker-api:latest'
        REMOTE_SERVER  = '192.168.1.37'            // Your server IP (local or public)
        REMOTE_USER    = 'ubuntu'                 // SSH username (e.g., ubuntu, ec2-user, root)
        SSH_KEY        = credentials('jenk') // Jenkins credentials ID for SSH private key
        DOCKERHUB_CREDS = 'docker-id'    // Jenkins credentials ID for Docker Hub
    }

    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/susindraa/24-node-docker-api.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t %DOCKER_IMAGE% .'
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('', DOCKERHUB_CREDS) {
                        bat 'docker push %DOCKER_IMAGE%'
                    }
                }
            }
        }

        stage('Deploy to Remote Server') {
            steps {
                script {
                    sshagent([SSH_KEY]) {
                        bat """
                            ssh -o StrictHostKeyChecking=no $REMOTE_USER@$REMOTE_SERVER << 'EOF'
                                docker pull $DOCKER_IMAGE
                                docker stop \$(docker ps -q --filter "name=node-docker-api") || true
                                docker rm \$(docker ps -aq --filter "name=node-docker-api") || true
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
            echo "✅ Deployment succeeded!"
        }
        failure {
            echo "❌ Deployment failed!"
        }
    }
}


