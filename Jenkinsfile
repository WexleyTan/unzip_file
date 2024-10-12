pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "${IMAGE}:${BUILD_NUMBER}"
        DOCKER_CREDENTIALS_ID = "dockertoken"
    }
    stages {
        stage('Unzip File') {
            steps {
                script {
                    echo "Checking if the file 'demo.zip' exists and unzipping it if present..."
                    sh """
                        if [ -f 'demo.zip' ]; then
                            echo "File 'demo.zip' exists, unzipping it..."
                            unzip demo.zip
                        else
                            echo "File 'demo.zip' does not exist, skipping unzip."
                        fi
                    """
                }
            }
        }
    }
}
