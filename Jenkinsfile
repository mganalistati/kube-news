pipeline {
    agent any

    stages {

        stage ('Build Docker Image') {
            steps {
                script {
                    dockerapp = docker.build("mganalistati/kube-news:${env.BUILD_ID}", '-f ./src/Dockerfile ./src')
                }
            }
        }

        stage ('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_credentials') {
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")    
                    }
                }
            }
        }

        stage ('Deploy to kubernetes') {
            environment {
                tag_version = "${env.BUILD_ID}"
            }
            steps {
                withKubeConfig([credentialsId: 'kubeconfig']) {
                    sh 'sed -i "s/{{TAG}}/$tag_version/g" ./manifests/application-deployment.yaml' 
                    sh 'kubectl apply -f ./manifests/application-deployment.yaml'
                }
            }
        } 
    }

}