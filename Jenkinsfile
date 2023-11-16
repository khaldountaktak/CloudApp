pipeline {
agent none

stages{
        agent {
            docker {
            image 'node:20.9.0-alpine3.18'
            args '-p 3000:3000'
        }
        }
    stage("Build"){
            steps {
                dir("test-app"){
                sh "pwd"
                sh "ls -a"
                sh "npm install"
                sh "npm run build"
                }
    }
    }

    stage("Deploy"){
        agent {
            docker {
                image "hashicorp/terraform"
            }
        }
        steps{
            dir("terraform"){

                    withCredentials([
    string(credentialsId: 'aws_access_key_id', variable: 'AWS_ACCESS_KEY_ID'),
    string(credentialsId: 'aws_secret_access_key', variable: 'AWS_SECRET_ACCESS_KEY')
]){
                    sh "terraform init -backend-config=bucket=tf-state-jenkins-test -backend-config=region=eu-west-3 -backend-config=./terraform"
                    sh "terraform apply --auto-approve"
}
            }
        }
    }
}
}