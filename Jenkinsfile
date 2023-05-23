pipeline{
    agent any
    stages{
        stage("Git checkout"){
            steps{
                echo "========executing git checkout========"

                git branch: 'main', url: 'https://github.com/latesh-11/task-1.git'
            }
        }
        stage("Unit test"){
            steps{
                echo "========executing unit test========"

               script{
                sh 'mvn test'
               }
            }
        }
        stage("Integration testing"){
            steps{
                echo "========executing Integration testing========"

               script{
                sh 'mvn verify -DskipUnitTest'
               }
            }
        }
        stage("maven build"){
            steps{
                echo "========executing Maven build========"

               script{
                sh 'mvn clean install'
               }
            }
        }
        stage("Docker image build "){
            steps{
                echo "========executing docekr image build========"

               script{
                sh '''
                    docker build -t latesh .
                    ddocker tag latesh:latest 252820710416.dkr.ecr.ap-northeast-1.amazonaws.com/latesh:latest
                    '''
               }
            }
        }
        stage("Docker image push "){
            steps{
                echo "========executing docekr image push========"
               withDockerRegistry(credentialsId: 'ecr:ap-northeast-1:AWS_creds', url: 'https://252820710416.dkr.ecr.ap-northeast-1.amazonaws.com/latesh') {
                    script{
                    sh '''
                        aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 252820710416.dkr.ecr.ap-northeast-1.amazonaws.com
                        docker push 252820710416.dkr.ecr.ap-northeast-1.amazonaws.com/latesh:latest

                        docker image rm -f 252820710416.dkr.ecr.ap-northeast-1.amazonaws.com/latesh:latest
                        '''
                    }
                }
            }
        }
    }
}