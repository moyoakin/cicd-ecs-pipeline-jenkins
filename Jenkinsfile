pipeline {
    agent any

    environment {
        AWS_REGION = 'us-east-1'
        ACCOUNT_ID = '022499010943'
        FRONTEND_REPO = 'techpathway-frontend'
        BACKEND_REPO = 'techpathway-backend'
        ECS_CLUSTER = 'techpathway-cluster'
        FRONTEND_SERVICE = 'techpathway-frontend-service'
        BACKEND_SERVICE = 'techpathway-backend-service'
        IMAGE_TAG = 'latest'
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/moyoakin/cicd-ecs-pipeline-jenkins.git'
            }
        }

        stage('Login to ECR') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    sh '''
                    aws ecr get-login-password --region $AWS_REGION | docker login \
                    --username AWS \
                    --password-stdin \
                    $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
                    '''
                }
            }
        }

        stage('Build Backend Image') {
            steps {
                sh '''
                docker build -t $BACKEND_REPO ./backend

                docker tag \
                $BACKEND_REPO:$IMAGE_TAG \
                $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACKEND_REPO:$IMAGE_TAG
                '''
            }
        }

        stage('Build Frontend Image') {
            steps {
                sh '''
                docker build -t $FRONTEND_REPO ./frontend

                docker tag \
                $FRONTEND_REPO:$IMAGE_TAG \
                $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONTEND_REPO:$IMAGE_TAG
                '''
            }
        }

        stage('Push Images to ECR') {
            steps {
                sh '''
                docker push \
                $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$BACKEND_REPO:$IMAGE_TAG

                docker push \
                $ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$FRONTEND_REPO:$IMAGE_TAG
                '''
            }
        }

        stage('Deploy to ECS') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'aws-creds'
                ]]) {
                    sh '''
                    aws ecs update-service \
                    --cluster $ECS_CLUSTER \
                    --service $BACKEND_SERVICE \
                    --force-new-deployment \
                    --region $AWS_REGION

                    aws ecs update-service \
                    --cluster $ECS_CLUSTER \
                    --service $FRONTEND_SERVICE \
                    --force-new-deployment \
                    --region $AWS_REGION
                    '''
                }
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}