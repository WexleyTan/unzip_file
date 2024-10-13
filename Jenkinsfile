pipeline {
    agent any
    tools {
        maven 'maven'
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
                        fi
                    """
                }
            }
        }
        stage("Check for pom.xml") {
            steps {
                script {
                    echo "Checking for 'pom.xml'..."
                    def pomFileExists = sh(script: "test -f demo/pom.xml && echo true || echo false", returnStdout: true).trim()
                    if (pomFileExists == "true") {
                        echo "'pom.xml' exists. Proceeding to clean package."
                    } else {
                        error "'pom.xml' does not exist. Aborting build."
                    }
                }
            }
        }
        stage("clean package") {
            steps {
              echo "Building the application..."
              sh ' mvn clean install '
            }
        }

        stage("Build") {
            steps {
                echo "Building Docker image..."
                sh 'docker build -t ${DOCKER_IMAGE} .'
            }
        }
    }
}
