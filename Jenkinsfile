pipeline {
    agent any

    stages {
        stage('Unzip File') {
            steps {
                sh ' unzip -o auto_deploy.zip '   
            }
        }

        stage("Build") {
            steps {
                script {
                    echo "Building the Maven project..."
                    sh 'mvn clean install'

                    echo "Building Docker image..."
                    sh 'docker build -t springboot_jenkins demo/auto_deploy/'
                }
            }
        }
    }
}
