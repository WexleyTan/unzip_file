pipeline {
    agent any
    tools {
        maven 'maven'
    }
    environment {
        IMAGE = "spring_unzip"
        FILE_NAME = "auto_deploy.zip"
        DIR_UNZIP = "demo" 
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
                        fi
                    """
                }
            }
        }

        stage("Build Docker Image") {
            steps {
                script {
                    echo "Building the Maven project..."
                    sh """
                        if [ -f '${DIR_UNZIP}/pom.xml' ]; then  
                            cd ${DIR_UNZIP}  
                            mvn clean install
                        fi
                    """

                    echo "Building Docker image..."
                    sh "docker build -t ${DOCKER_IMAGE} ."  
                }
            }
        }

        stage("Test") {
            steps {
                script {
                    echo "Testing the application"
                    // Add testing commands here if needed
                }
            }
        }

        stage("Deploy") {
            steps {
                script {
                    echo "Deploying the Docker container..."
                    sh """
                        docker start ${DOCKER_CONTAINER} || docker run --name ${DOCKER_CONTAINER} -d -p 9090:8080 ${DOCKER_IMAGE}
                    """
                    sh 'docker ps'  // List running Docker containers
                }
            }
        }
    }
}
