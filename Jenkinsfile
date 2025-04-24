pipeline {
    agent any

    tools {
        nodejs 'nodejs-23.11.0' // Use Node.js for the project
    }

    environment {
        DOCKER_IMAGE = 'susindraa/node-docker-api:latest' // Docker image name
        DOCKER_REGISTRY = 'docker.io' // Docker registry
        PORT = '8080' // Exposed port
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/susindraa/24-node-docker-api.git' // Checkout the code
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'npm install' // Install Node.js dependencies
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t susindraa/node-docker-api . ' // Build the Docker image
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container in detached mode
                    sh "docker run -d -p ${PORT}:${PORT} ${DOCKER_IMAGE}"
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                script {
                    // Verify the container is running
                    sh 'docker ps'
                }
            }
        }

        stage('Post-Cleanup') {
            steps {
                script {
                    // Optionally clean up Docker images or containers after deployment
                    sh 'docker system prune -f'
                }
            }
        }
    }

    post {
        always {
            // Clean up Docker resources after the pipeline run
            sh 'docker system prune -f'
        }
    }
}
