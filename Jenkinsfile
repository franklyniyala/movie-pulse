pipeline{
    agent any
    environment{
        IMAGE_NAME = 'my-app:v1.0'
        IMAGE_TAG = 'v1'
        DOCKER_CREDENTIAL_ID = "dockerlogin"

    }

    stages{
        stage('checkout code'){
            steps{
                git branch: 'main', url: 'https://github.com/waleolajumoke/moviepulse'
            }

        }

        stage("Build docker image"){
            steps{
                sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
            }

        }

        stage('Login to docker hub'){
            steps{
                withCredentials([usernamePassword(credentialId: "$DOCKER_CREDENTIAL_ID")])
            }
        }

        stage("push to docker hub"){
            steps{
                sh 'docker push $IMAGE_NAME:$IMAGE_TAG'
            }
        }
    }

    post{
        suceess{
            echo "React image build and pushed successfully"
        }
        failure{
            echo "Pipeline failed"
        }
    }
}