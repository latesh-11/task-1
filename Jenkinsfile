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
        stage("eks deployment"){
            when { expression { params.action == 'create' } }
            
            steps{
                echo "========executing eks deployment========"
                sh "cp /var/lib/jenkins/bin/kubectl ."
                sh "ls -l"

                script{
                    def apply = false
                    try{
                        input massage: 'please confirm the apply to initita the deployments', ok: 'Ready to apply the config'
                        apply = true
                    }        
                    catch(err){
                        apply = false
                        CurrentBuild.result = 'UNSTABLE'
                    }
                    if(apply){
                            // deploy all manifest files
                        sh "cp /var/lib/jenkins/bin/kubectl ."
                        sh "chmod +x kubectl"
                        sh "ls -l"
                        sh """
                            ./kubectl apply -f .
                            """
                    }
                }
            }
        }
         stage("delete deployment"){
            when {expression {params.action == 'destroy'}}
            steps{
                echo "========executing delete deployment========"
                
                script {
                    def destroy = falce

                    try{
                        input massage: 'please confirm the destroy to delete the deployments' , ok: 'Ready to destroy the config'
                        destroy = true
                    }
                    catch(err){
                        destroy = false
                        CurrentBuild.result= 'UNSTABLE'
                    } 
                    if(destroy){
                        sh """
                            ./kubectl delete -f .
                            """
                    }
                }
            }
         }
    }

}