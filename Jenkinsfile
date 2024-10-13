pipeline {
    agent any
    tools {
        maven 'maven'  // Ensure the Maven tool is correctly specified
    }
    environment {
        IMAGE = "spring_unzip"
        FILE_NAME = "auto_deploy.zip"
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
                            rm -rf demo/  // Remove the demo directory to ensure a clean state
                            echo "Unzipping the file..."
                            unzip -o '${FILE_NAME}' -d demo/  // Unzip into the demo directory
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
                        if [ -f '${FILE_NAME}/pom.xml' ]; then
                            cd ${FILE_NAME}  // Change to the directory containing pom.xml
                            mvn clean install
                        else
                            echo "POM file not found, cannot build the project."
                            error "Build failed due to missing POM file."
                        fi
                    """

                    echo "Building Docker image..."
                    sh "docker build -t ${DOCKER_IMAGE} ."  
                }
            }
        }
    }
}


