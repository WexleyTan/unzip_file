pipeline {
    agent any

    stages {
        stage('Unzip File') {
            steps {
                script {
                    echo "Checking if the file 'auto_deploy.zip' exists and unzipping it if present..."
                    sh '''
                        if [ -f 'auto_deploy.zip' ]; then
                            echo "Removing existing files..."
                            rm -rf . .
                            echo "Unzipping the file..."
                            unzip -o auto_deploy.zip -d demo/
                        else
                            echo "'auto_deploy.zip' does not exist."
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
                    sh 'docker build -t unzip_jenkins .' // Adjust path if necessary
                }
            }
        }

        stage("Deploy") {
            steps {
                script {
                    echo "Deploying the Docker container..."
                    sh '''
                        if [ "$(docker ps -q -f name=springboot_jenkins-v1)" ]; then
                            echo "Starting existing container..."
                            docker start springboot_jenkins-v1
                        else
                            echo "Running a new container..."
                            docker run --name springboot_jenkins-v1 -d -p 9090:8080 unzip_jenkins
                        fi
                    '''
                }
            }
        }
    }
}
