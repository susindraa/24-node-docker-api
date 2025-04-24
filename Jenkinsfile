
pipeline {
    agent any

    tools {
        nodejs 'nodejs-23.11.0'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/susindraa/24-node-docker-api.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t susindraa/node-docker-api .'
            }
        }
    }
}
