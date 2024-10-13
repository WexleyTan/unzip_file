pipeline {
    agent any
    tools {
        maven 'maven' 
    }
    environment {
        IMAGE = "spring_unzip"
        FILE_NAME = "auto_deploy.zip"
        DIR_UNZIP = "pom.xml"  // Directory to unzip the files
        DOCKER_IMAGE = "${IMAGE}:${BUILD_NUMBER}"
        DOCKER_CONTAINER = "springboot_jenkins"
        DOCKER_CREDENTIALS_ID = "dockertoken"
    }

    stages {
        stage('Unzip File') {
            steps {
                script {
                    echo "Checking if the file ${FILE_NAME} exists and unzipping it if present..."
                    sh """
                        if [ -f '${FILE_NAME}' ]; then
                            echo "Removing existing files..."
                            rm -rf ${DIR_UNZIP}  
                            echo "Unzipping the file..."
                            unzip -o '${FILE_NAME}' -d ${DIR_UNZIP}/
                    """
                }
            }
        }

        stage("Build Docker Image") {
            steps {
                script {
                    echo "Building the Maven project..."
                    sh """
                        if [ -f '${DIR_UNZIP}' ]; then
                            mvn clean install
                        fi
                    """

                    echo "Building Docker image..."
                    sh "docker build -t ${DOCKER_IMAGE} ."  
                }
            }
        }
         stage("test") {
            steps {
                echo "testing the application"
            }
        }

        stage("deploy") {
            steps {
                sh 'docker start ${DOCKER_CONTAINER} || docker run --name ${DOCKER_CONTAINER} -d -p 9090:8080 ${DOCKER_IMAGE} '
                sh ' docker ps '
            }
        }
    }
    }
}


