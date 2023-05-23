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
                    docker image build -t ${JOB_NAME}:V.${BUILD_ID} .
                    docker image tag ${JOB_NAME}:V.${BUILD_ID} latesh/${JOB_NAME}:V.${BUILD_ID}
                    docker image tag ${JOB_NAME}:V.${BUILD_ID} latesh/${JOB_NAME}:latest
                    '''
               }
            }
        }
    }
}