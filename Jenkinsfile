pipeline {
    agent any
    
    environment {
        DOCKER_REGISTRY = "docker.io"
        DOCKER_IMAGE = "g3niuz/mybucks"
        DOCKER_TAG = "latest"
    }
    
    stages {
        stage('Clone Repository') {
            steps {
                echo 'Cloning Starbucks repository...'
                dir('web-app') {
                    git branch: 'main', url: 'https://github.com/masimgul81/starbucks.git'
                }
            }
        }
        
        stage('Build Docker Image') {
            steps {
                echo 'Building Docker image...'
                script {
                    docker.build("${env.DOCKER_IMAGE}:${env.DOCKER_TAG}", "./web-app")
                }
            }
        }
        
        stage('Login to Docker Hub') {
            steps {
                echo 'Logging in to Docker Hub...'
                script {
                    withCredentials([usernamePassword(
                        credentialsId: 'docker-hub-creds',
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )]) {
                        sh """
                            docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD
                        """
                    }
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                echo 'Pushing image to Docker Hub...'
                script {
                    sh """
                        docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
            
            post {
                always {
                    sh 'docker logout'
                }
            }
        }
        
        stage('Deploy to Kubernetes') {
            steps {
                script {    
                    sh """
                        kubectl apply -f deployment.yaml --validate=false
                        
                    """
                }
                
                sh """
                    kubectl rollout status deployment/mybucks -n starbucks --timeout=120s
                """
            }
        }

    }
    
    post {
        failure {
            echo 'Pipeline failed! Checking authentication status...'
            sh 'docker info || true'
            sh 'docker images || true'
        }
        cleanup {
            echo 'Cleaning up workspace...'
            // Clean up Docker images to save space
            sh 'docker rmi ${DOCKER_IMAGE}:${DOCKER_TAG} || true'
        }
    }
}