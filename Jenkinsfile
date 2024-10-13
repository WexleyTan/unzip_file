pipeline {
    agent any
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
                        fi
                    """
                }
            }
        }

        stage("Build") {
            steps {
                script {
                    echo "Navigating to the project directory..."
                    dir('path/to/your/project/directory') {
                        echo "Building the Maven project..."
                        sh 'mvn clean install'
        
                        echo "Building Docker image..."
                        sh 'docker build -t ${DOCKER_IMAGE}.'
                    }
                }
            }
        }
    }
}

