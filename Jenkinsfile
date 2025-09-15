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
                    docker.build("g3niuz/mybucks:latest")
                    docker.push("g3niuz/mybucks:latest")
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