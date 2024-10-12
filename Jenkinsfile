pipeline {
    agent any
    
    stages {
        stage('Unzip File') {
            steps {
                script {
                    echo "Checking if the file 'demo.zip' exists and unzipping it if present..."
                    sh """
                        if [ -f 'demo.zip' ]; then
                            echo "Removing existing files..."
                            rm -rf demo/
                            unzip demo.zip
                        else
                            echo "File 'demo.zip' does not exist, skipping unzip."
                        fi
                    """
                }
            }
        }

        stage("Build") {
            steps {
                script {
                    echo "Building the Maven project..."
                    sh 'mvn clean install'
                    
                    echo "Building Docker image..."
                    sh 'docker build -t springboot_jenkins .'
                }
            }
        }
        stage("Deploy") {
            steps {
                script {
                    echo "Deploying Docker container..."
                    sh """
                        if [ \$(docker ps -a -q -f name=springboot_jenkins) ]; then
                            echo "Container 'springboot_jenkins' already exists, starting it..."
                            docker start springboot_jenkins
                        else
                            echo "Running a new container..."
                            docker run --name springboot_jenkins -d -p 9090:8080 springboot_jenkins
                        fi
                    """
                    sh 'docker ps'
                }
            }
        }
    }
}
