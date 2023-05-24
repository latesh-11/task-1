pipeline{
    agent any

    parameters{
        choice (name: 'action' , choices: [ 'create' , 'destroy' ] , description: 'Create OR Destroy the cluster')
        string(name: 'cluster' , defaultValue: 'myEKS' , description: 'EKS cluster name')
        string(name: 'region' , defaultValue: 'ap-northeast-1' , description: 'EKS cluster region')
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
                sh """
                    aws configure set aws_access_key_id "${env.AWS_ACCESS_KEY_ID}"
                    aws configure set aws_secret_access_key "${env.AWS_SECRET_ACCESS_KEY}"
                    aws configure set region "${env.AWS_DEFAULT_REGION}"
                    aws eks --region "${params.region}" update-kubeconfig --name "${params.cluster}"
                """
                
            }
        }
        stage("create pod"){
            when { expression { params.action == 'create' } }
            steps{
                echo "========executing create pod========"
                sh "kubectl apply -f . "      
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