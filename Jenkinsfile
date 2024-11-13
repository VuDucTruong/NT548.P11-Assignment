pipeline {
    agent { label 'docker-node' } // Label của agent Docker

    environment {
        REGISTRY = 'docker.io'
        DOCKER_CREDENTIALS_ID = 'docker-hub-credentials-id'
        //KUBE_CONFIG = credentials('kubeconfig')
    }

    stages {
        stage('Checkout') {
            steps {
                // Kiểm tra mã nguồn từ Git
                git url: 'https://github.com/VuDucTruong/spring-boot-microservices-series', branch: 'master'
            }
        }

        stage('Build') {
            steps {
                script {
                    // Lặp qua các thư mục microservices và build chúng
                    def services = ['catalog-service']
                    services.each { service ->
                        dir(service) {
                            // Build và tạo Docker image
                            sh "docker build -t ${REGISTRY}/${service}:${env.BUILD_NUMBER} ./${service}"
                        }
                    }
                }
            }
        }

        stage('Push to Registry') {
            steps {
                script {
                    
                    docker.withRegistry("https://${REGISTRY}", DOCKER_CREDENTIALS_ID) {
                        services.each { service ->
                            // Push từng Docker image lên registry
                            sh "docker push ${REGISTRY}/${service}:${env.BUILD_NUMBER}"
                        }
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Sử dụng kubeconfig để kết nối đến cluster
                    // withKubeConfig([credentialsId: 'kubeconfig']) {
                    //     def services = ['service1', 'service2', 'service3']
                    //     services.each { service ->
                    //         // Tạo hoặc cập nhật deployment cho từng microservice
                    //         sh """
                    //         kubectl set image deployment/${service} ${service}=${REGISTRY}/${service}:${env.BUILD_NUMBER} -n your-namespace
                    //         kubectl rollout status deployment/${service} -n your-namespace
                    //         """
                    //     }
                    // }
                    echo 'Complete deployment'
                }
            }
        }
    }

    post {
        always {
            node('agent-1') { // Đảm bảo cleanWs nằm trong node
                cleanWs()
            }
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}
