pipeline {
    agent any

    environment {
        IMAGE_NAME = "quote-generator:latest"
        TEST_CONTAINER = "quote-generator-test"
        PROD_CONTAINER = "quote-generator-prod"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Run container and health check') {
            steps {
                sh '''
                    docker rm -f $TEST_CONTAINER || true
                    docker run -d --name $TEST_CONTAINER -p 5001:5000 $IMAGE_NAME
                    sleep 5
                    docker exec $TEST_CONTAINER python -c "import urllib.request; print(urllib.request.urlopen('http://127.0.0.1:5000/health').read().decode())"
                    docker rm -f $TEST_CONTAINER
                '''
            }
        }

        stage('Deploy application') {
            steps {
                sh '''
                    docker rm -f $PROD_CONTAINER || true
                    docker run -d --name $PROD_CONTAINER --restart always -p 5000:5000 $IMAGE_NAME
                    sleep 5
                    docker exec $PROD_CONTAINER python -c "import urllib.request; print(urllib.request.urlopen('http://127.0.0.1:5000/health').read().decode())"
                '''
            }
        }
    }

    post {
        always {
            sh 'docker ps -a || true'
        }
    }
}