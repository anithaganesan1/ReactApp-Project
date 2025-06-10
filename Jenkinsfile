pipeline {
    agent any

    environment {
        DEV_IMAGE = "aniganesan/dev"
        PROD_IMAGE = "aniganesan/prod"
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
                script {
                    def imageName = env.BRANCH_NAME == 'master' ? env.PROD_IMAGE : env.DEV_IMAGE
                    echo "🐳 Building image for branch ${env.BRANCH_NAME} → ${imageName}"
                    sh "docker build -t ${imageName} ."
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    def imageName = env.BRANCH_NAME == 'master' ? env.PROD_IMAGE : env.DEV_IMAGE
                    echo "📤 Pushing ${imageName} to Docker Hub..."
                    withCredentials([usernamePassword(credentialsId: env.DOCKER_HUB_CREDENTIALS, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh """
                            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                            docker push ${imageName}
                        """
                    }
                }
            }
        }

        stage('Deploy Container') {
            when {
                branch 'dev'
            }
            steps {
                echo '🚀 Deploying dev container...'
                sh 'chmod +x deploy.sh && ./deploy.sh'
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
