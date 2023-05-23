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
    }
}