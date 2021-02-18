pipeline {
  agent any
  tools {
        terraform 'terraform'
    }
  environment {
    TERRAFORM_HOME = "terraform"
  }
  stages {
    stage('Terraform Init') {
      steps {
        dir("terraform") {
             sh "pwd"
          withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'access_key', credentialsId: 'aws_key', secretKeyVariable: 'secret_key']]) {
              // some block
              sh 'terraform init --backend-config="access_key=$access_key" --backend-config="secret_key=$secret_key"'
          }
        }
          // sh "${env.TERRAFORM_HOME}/terraform init -input=false"
      }
    }
    stage('Terraform Plan') {
      steps {
        dir("terraform") {
          sh "terraform plan -out=tfplan -input=false"
        }
      }
    }
    stage('Terraform Apply') {
      steps {
         dir("terraform") {
          input 'Apply Plan'
          sh "terraform apply -input=false tfplan"
        }
      }
    }
  }
}
