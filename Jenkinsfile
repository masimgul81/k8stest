//creating a simple pipeline
pipeline {
    agent any
    
    stages {
        stage('clone repo') {
            steps {
                echo 'Building...'
                dir('./web-app') {
                    git branch: 'main', url: 'https://github.com/masimgul81/starbucks.git'
                }
            }
        }
        stage('building Docker Image & Push') {
            steps {
                echo 'Testing...'
                sh '''
                    dockerImage = docker.build("g3niuz/mybucks:latest", "./web-app")
                    dockerImage.push()
                    dockerImage.push("latest")
                '''
                //sh docker.build("g3niuz/mybucks").push()
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
            }
        }
    }
}