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
        stage('Run SonarQube Analysis') {
            steps {
                script {
                    dir('run-aspnetcore-microservices/src') {
                            bat 'dotnet sonarscanner begin /k:"aspnet_project" /d:sonar.login="squ_394bcd938dd6831deb74d9d722b10d8ca0f647b0" /d:sonar.verbose=true /d:sonar.host.url="http://localhost:9000"'
                        }
                }
            }
        }
        stage('Build dotnet') {
            steps {
                script {
                        dir('run-aspnetcore-microservices/src') {
                            bat 'dotnet build eshop-microservices.sln'
                        }
                }
            }
        }
        stage('End SonarQube') {
            steps {
                script {
                        dir('run-aspnetcore-microservices/src') {
                            bat 'dotnet sonarscanner end /d:sonar.login="squ_394bcd938dd6831deb74d9d722b10d8ca0f647b0"'
                        }
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
