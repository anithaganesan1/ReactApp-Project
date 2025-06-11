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
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def imageName = env.BRANCH_NAME == 'main' ? env.PROD_IMAGE : env.DEV_IMAGE
                    echo " Building image for branch ${env.BRANCH_NAME} → ${imageName}"
                    sh "chmod +x build.sh && ./build.sh ${imageName}"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    def imageName = env.BRANCH_NAME == 'main' ? env.PROD_IMAGE : env.DEV_IMAGE
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
                anyOf {
                    branch 'dev'
                    branch 'main'
                }
            }
            steps {
                script {
                    echo "🚀 Deploying container for ${env.BRANCH_NAME}..."
                    sh "chmod +x deploy.sh"
                    sh "./deploy.sh ${env.BRANCH_NAME}"
                }
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
