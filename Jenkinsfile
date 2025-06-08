pipeline {
    agent any
    environment {
        IMAGE_NAME = "anithaganesan1/dev"
        PROD_IMAGE_NAME = "anithaganesan1/prod"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-id')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: "${env.BRANCH_NAME}", url: 'https://github.com/anithaganesan1/React-app--Deploy.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'chmod +x build.sh'
                    sh './build.sh'
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-id') {
                        if (env.BRANCH_NAME == 'master') {
                            sh "docker tag ${IMAGE_NAME}:latest ${PROD_IMAGE_NAME}:latest"
                            sh "docker push ${PROD_IMAGE_NAME}:latest"
                        } else if (env.BRANCH_NAME == 'dev') {
                            sh "docker push ${IMAGE_NAME}:latest"
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'chmod +x deploy.sh'
                    sh './deploy.sh'
                }
            }
        }
    }

    triggers {
        githubPush()
    }
}
