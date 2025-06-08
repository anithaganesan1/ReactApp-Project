pipeline {
    agent any

    environment {
        IMAGE_NAME = "anithaganesan1/dev"
        PROD_IMAGE_NAME = "anithaganesan1/prod"
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-id')
        BRANCH_NAME = "${env.GIT_BRANCH}".replaceFirst(/^origin\//, '')  // Normalize branch name
    }

    triggers {
        githubPush()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
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
            when {
                anyOf {
                    branch 'dev'
                    branch 'master'
                }
            }
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS) {
                        if (BRANCH_NAME == 'master') {
                            sh "docker tag ${IMAGE_NAME}:latest ${PROD_IMAGE_NAME}:latest"
                            sh "docker push ${PROD_IMAGE_NAME}:latest"
                        } else if (BRANCH_NAME == 'dev') {
                            sh "docker push ${IMAGE_NAME}:latest"
                        }
                    }
                }
            }
        }

        stage('Deploy') {
            when {
                branch 'master'
            }
            steps {
                script {
                    sh 'chmod +x deploy.sh'
                    sh './deploy.sh'
                }
            }
        }
    }
}
