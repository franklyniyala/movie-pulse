pipeline{
    agent any
    stages{
        stage('checkout code'){
            steps{
                git branch: 'main', 
                credentialsId: 'GITHUB_LOGIN',
                url: 'https://github.com/franklyniyala/movie-pulse.git'
            }

        }

        stage('Sonarqube Analysis'){
            steps{
                withCredentials([string(credentialsId: 'SONAR_TOKEN', variable: 'SONAR_TOKEN')]){
                    sh '''
                    docker run --rm \
                    -e SONAR_TOKEN=$SONAR_TOKEN \
                    -v $(pwd):/usr/src \
                    sonarsource/sonar-scanner-cli \
                    -Dsonar.projectKey=frank-org_movie-pulse \
                    -Dsonar.organiztion=frank-org \
                    -Dsonar.sources=. \
                    -Dsonar.host.url=http://sonarcloud.io \
                    '''

                }
            }
        }

        stage("Build docker image"){
            steps{
                sh 'docker build -t ekenefranklyn/movie-pulse:v1 .'
            }

        }

        stage('Login to docker hub'){
            steps{
                withCredentials([usernamePassword(
                    credentialsId: 'DOCKER_LOGIN',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                    )]){
                        sh '''
                            echo $PASSWORD | docker login -u $USERNAME --password-stdin
                        '''
                    }
            }
        }

        stage("Push to Docker Hub") {
            steps { 
                    sh 'docker push ekenefranklyn/movie-pulse:v1'
                }
            }

        stage('Deploy Application') {
            steps {
                sh '''
                    docker stop movie-pulse || true
                    docker rm movie-pulse || true
                    docker run -d -p 2500:80 --name movie-pulse ekenefranklyn/movie-pulse:v1
                '''
            }
        }
    }

    post {
        success {
            echo "✅ React image built and pushed successfully"
        }
        failure {
            echo "❌ Pipeline failed"
        }
    }
}