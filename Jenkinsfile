pipeline {
    agent any
    tools {
        maven 'maven' 
    }
    environment {
        IMAGE = "spring_unzip"
        FILE_NAME = "auto_deploy.zip"
        DIR_UNZIP = "demo"  // Directory to unzip the files
        DOCKER_IMAGE = "${IMAGE}:${BUILD_NUMBER}"
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
                        else
                            echo "'${FILE_NAME}' does not exist."
                            exit 1
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
                        else
                            echo "POM file not found, cannot build the project."
                            error "Build failed due to missing POM file."
                        fi
                    """

                    echo "Building Docker image..."
                    sh "docker build -t ${DOCKER_IMAGE} ${DIR_UNZIP}/"  // Specify DIR_UNZIP as the context
                }
            }
        }
    }
}


