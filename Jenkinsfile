pipeline{
    agent any

    }

    stages{
        stage('checkout code'){
            steps{
                git branch: 'main', url: 'https://github.com/franklyniyala/moviepulse'
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
                    credentialId: 'DOCKER_LOGIN',
                    usernameVariable: 'USERNAME',
                    passwordVariable: 'PASSWORD'
                    )]){
                        sh '''
                            echo '$PASSWORD | docker login -u $USERNAME --password-stdin
                        '''
                    }
            }
        }

        stage("push to docker hub"){
            steps{
                sh 'docker push ekenefranklyn/movie-pulse:v1'
            }
        }
    }

    post{
        success{
            echo " ✅ React image build and pushed successfully"
        }
        failure{
            echo " ❌ Pipeline failed"
        }

        stage('Deploy Application'){
            steps{
                sh '''
                    docker stop ekenefranklyn/movie-pulse || true
                    docker rm ekenefranklyn/movie-pulse || true
                    docker run -d -p 2500:80 --name movie-pulse ekenefranklyn/movie-pulse:v1
                '''
            }
        }
    }
