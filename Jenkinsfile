//creating a simple pipeline
pipeline {
    agent any
    
    stages {
        stage('clone repo') {
            steps {
                echo 'Building...'
                dir('web-app') {
                    git branch: 'main', url: 'https://github.com/masimgul81/starbucks.git'
                }
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}