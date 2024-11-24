pipeline {
    agent {
        label 'asp-agent'
    }
    environment {
        // Định nghĩa các biến môi trường
        WORKING_DIR = 'run-aspnetcore-microservices/src'
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
        stage('Run SonarQube Analysis') {
            steps {
                dir("${env.WORKING_DIR}") {
                    withSonarQubeEnv('sq-1') {
                        bat 'dotnet sonarscanner begin  /k:"aspnet_project"'
                    }
                }
            }
        }
        stage('Build dotnet') {
            steps {
                dir("${env.WORKING_DIR}") {
                    bat 'dotnet build eshop-microservices.sln'
                }
            }
        }
        stage('End SonarQube') {
            steps {
                dir("${env.WORKING_DIR}") {
                    withSonarQubeEnv('sq-1') {
                        bat 'dotnet sonarscanner end'
                    }
                }
            }
        }
        stage('Run docker compose') {
            steps {
                dir("${env.WORKING_DIR}") {
                    bat 'docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d'
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
