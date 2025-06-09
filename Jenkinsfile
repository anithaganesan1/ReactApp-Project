pipeline {
    agent any

    environment {
        IMAGE_NAME = "anithaganesan1/react-app"
        //DOCKER_CREDENTIALS_ID = "dockerhub-creds"
        DOCKER_CREDENTIALS_ID = "dockerhub-id"

    }

    tools {
        nodejs "NodeJS_22"  // You must configure this NodeJS tool in Jenkins → Global Tool Configuration
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "🔍 Checking out source code..."
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                echo "📦 Installing NPM packages..."
                sh 'npm install'
            }
        }

        stage('Build React App') {
            steps {
                echo "🔨 Building React app..."
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def branch = sh(script: "git rev-parse --abbrev-ref HEAD", returnStdout: true).trim()
                    env.TAG = branch
                    echo "🐳 Building Docker image: ${IMAGE_NAME}:${TAG}"
                    sh "docker build -t ${IMAGE_NAME}:${TAG} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    echo "🔐 Logging in to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                        sh "docker push ${IMAGE_NAME}:${TAG}"
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ Pipeline completed successfully!"
        }
        failure {
            echo "❌ Pipeline failed!"
        }
    }
}
