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
                            rm -rf auto_deploy/
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
                    echo "Navigating to the project directory..."
                    dir('demo/auto_deploy') { // Update this path to where your pom.xml is located
                        echo "Building the Maven project..."
                        sh 'mvn clean install'

                        echo "Building Docker image..."
                        sh 'docker build -t springboot_jenkins .'
                    }
                }
            }
        }
        stage("test") {
            steps {
                echo "testing the application"
            }
        }

        stage("deploy") {
            steps {
                sh 'docker start springboot_jenkins || docker run --name springboot_jenkins-v1 -d -p 9090:8080 springboot_jenkins '
                sh ' docker ps '
            }
        }

    }
}
