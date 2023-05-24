pipeline{
    agent any

    parameters{
        choice (name: 'action' , choices: [ 'create' , 'destroy' ] , description: 'Create OR Destroy the cluster')
    }
    stages{
        stage("git checkout"){
            steps{
                echo "========executing git checkout========"

                git branch: 'main', url: 'https://github.com/latesh-11/task-1.git'
            }
        }
        
        stage("docker image pull"){
            steps{
                echo "========executing docker image pull========"

                script{
                    withDockerRegistry(credentialsId: 'ecr:ap-northeast-1:docker-login', url: 'https://252820710416.dkr.ecr.ap-northeast-1.amazonaws.com/latesh') {
                       sh "aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 252820710416.dkr.ecr.ap-northeast-1.amazonaws.com"
                       sh "docker pull 252820710416.dkr.ecr.ap-northeast-1.amazonaws.com/latesh:latest"
                    }
                }
            }
        }
        stage("eks connect"){
            steps{
                echo "========executing eks connect========"
                sh 'aws eks --region ap-northeast-1 update-kubeconfig --name myEKS '
                
            }
        }
        stage("create pod"){
            when { expression { params.action == 'create' } }
            steps{
                echo "========executing create pod========"

                sh "kubectl apply -f .  "              
            }
        }
        stage("destroy pod"){
            when { expression { params.action == 'destroy' } }
            steps{
                echo "========executing destroy pod========"

                sh "kubectl delete -f ." 
            }
            
        }
    }

}