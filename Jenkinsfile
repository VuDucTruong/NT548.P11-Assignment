pipeline {
    agent {
        label 'asp-node'
    }
    stages {
        stage('Check dotnet version') {
            steps {
                script {
                    bat 'dotnet --version'
                }
            }
        }
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout') {
            steps {
                script {
                    bat 'git clone https://github.com/VuDucTruong/run-aspnetcore-microservices'
                }
            }
        }
        stage('Run docker compose') {
            steps {
                script {
                    dir('run-aspnetcore-microservices/src') {
                        bat 'docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d'
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Triển khai ứng dụng (thêm bước triển khai thực tế của bạn)
                    echo 'Deploying the application...'
                }
            }
        }
    }

    post {
        success {
            echo 'Build and deployment succeeded!'
        }
        failure {
            echo 'Build failed.'
        }
    }
}
