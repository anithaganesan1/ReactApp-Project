pipeline {
    agent any

    environment {
        IMAGE_NAME = "aniganesan/dev"
        DOCKER_HUB_CREDENTIALS = 'dockerhub-id'
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo '📥 Checking out source code...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                echo '🐳 Building Docker image from pre-built files...'
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                echo '📤 Pushing Docker image to Docker Hub...'
                withCredentials([usernamePassword(credentialsId: "$DOCKER_HUB_CREDENTIALS", usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                        docker push $IMAGE_NAME
                    """
                }
            }
        }

        stage('Deploy Container') {
            steps {
                echo '🚀 Deploying container...'
                sh 'chmod +x deploy.sh'
                sh './deploy.sh'

            }
        }
    }

    post {
        failure {
            echo '❌ Build or deployment failed!'
        }
        success {
            echo '✅ Successfully built and deployed!'
        }
    }
}
