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
                    docker.withRepository('https://registry.hub.docker.com', 'dockerhub_credentials')
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")

                }
            }
        }
    }

}