pipeline {
    agent any

    tools {
        nodejs 'NodeJS_22' // Make sure this is configured in Jenkins Global Tool Config
    }

    environment {
        IMAGE_NAME = "aniganesan/dev"
        DOCKER_HUB_CREDENTIALS = 'dockerhub-id'  // Your DockerHub credentials ID in Jenkins
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo '📥 Checking out source code...'
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo '📦 Installing NPM packages...'
                // Run npm install in root repo folder or change if you want to install inside devops-build
                sh 'npm install'
                sh 'chmod -R +x node_modules/.bin'
            }
        }

        stage('Build React App') {
            steps {
                dir('devops-build') {
                    echo '🔨 Building React app...'
                    sh 'npm run build'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                dir('devops-build') {
                    echo '🐳 Building Docker image...'
                    // Using env var IMAGE_NAME is better
                    sh "docker build -t ${IMAGE_NAME} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                dir('devops-build') {
                    echo '📤 Pushing image to Docker Hub...'
                    withCredentials([usernamePassword(credentialsId: "${DOCKER_HUB_CREDENTIALS}", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                            echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                            docker push ${IMAGE_NAME}
                        """
                    }
                }
            }
        }
    }

    post {
        failure {
            echo '❌ Build or deployment failed!'
        }
        success {
            echo '✅ Build and deployment successful!'
        }
    }
}
