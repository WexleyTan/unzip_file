pipeline {
    agent any

    stages {
        stage('Unzip File') {
            steps {
                script {
                    echo "Checking if the file 'auto_deploy.zip' exists and unzipping it if present..."
                    sh """
                        if [ -f 'auto_deploy.zip' ]; then
                            echo "Removing existing files..."
                            rm -rf demo/
                            unzip -o auto_deploy.zip -d demo/  # Unzip into the demo directory
                        else
                            echo "File 'auto_deploy.zip' does not exist, skipping unzip."
                        fi
                    """
                }
            }
        }

        stage("Build") {
            steps {
                script {
                    echo "Checking for POM file before building the Maven project..."
                    sh """
                        if [ -f 'demo/pom.xml' ]; then
                            echo "Building the Maven project..."
                            cd demo  # Change directory to the unzipped project
                            mvn clean install
                        else
                            echo "POM file not found, cannot build the project."
                            error "Build failed due to missing POM file."
                        fi
                    """

                    echo "Building Docker image..."
                    sh 'docker build -t springboot_jenkins demo/' 
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
