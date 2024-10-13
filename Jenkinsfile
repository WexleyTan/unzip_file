pipeline {
    agent any
    tools {
        maven 'maven'  // Ensure the Maven tool is correctly specified
    }
    environment {
        IMAGE = "spring_unzip"
        DOCKER_IMAGE = "${IMAGE}:${BUILD_NUMBER}"
        DOCKER_CREDENTIALS_ID = "dockertoken"
    }

    stages {
        stage('Unzip File') {
            steps {
                script {
                    echo "Checking if the file 'auto_deploy.zip' exists and unzipping it if present..."
                    sh """
                        if [ -f 'auto_deploy.zip' ]; then
                            echo "Removing existing files..."
                            rm -rf auto_deploy/
                            echo "Unzipping the file..."
                            unzip -o auto_deploy.zip -d demo/
                        else
                            echo "'auto_deploy.zip' does not exist."
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
                        if [ -f 'demo/pom.xml' ]; then
                            cd demo  # Change to the directory containing pom.xml
                            mvn clean install
                        else
                            echo "POM file not found, cannot build the project."
                            error "Build failed due to missing POM file."
                        fi
                    """

                    echo "Building Docker image..."
                    sh "docker build -t ${DOCKER_IMAGE} demo/"  // Build the Docker image using the demo directory
                }
            }
        }
    }
}

