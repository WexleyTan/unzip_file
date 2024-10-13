pipeline {
    agent any
    environment {
        UNZIP_FILE = "auto_deploy.zip"
        DOCKER_IMAGE = "${IMAGE}:${BUILD_NUMBER}"
        DOCKER_CREDENTIALS_ID = "dockertoken"
    }
    
    stages {
        stage('Unzip File') {
            steps {
                script {
                    echo "Checking if the file '${env.UNZIP_FILE}' exists and unzipping it if present..."
                    sh '''
                        if [ -f "${UNZIP_FILE}" ]; then
                            echo "Removing existing files..."
                            rm -rf * 
                            echo "Unzipping the file..."
                            unzip -o "${UNZIP_FILE}" 
                        fi
                    '''
                }
            }
        }

        stage("Build") {
            steps {
                script {
                    echo "Building Docker image..."
                    // Specify the directory if needed
                    sh "docker build -t ${DOCKER_IMAGE} ." // Adjust path if necessary
                }
            }
        }
    }
}
