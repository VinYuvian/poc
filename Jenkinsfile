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
              sh "terraform init -input=false"
          }
        }
          // sh "${env.TERRAFORM_HOME}/terraform init -input=false"
      }
    }
    stage('Terraform Plan') {
      steps {
        sh "${env.TERRAFORM_HOME}/terraform plan -out=tfplan -input=false"
      }
    }
    stage('Terraform Apply') {
      steps {
        input 'Apply Plan'
        sh "${env.TERRAFORM_HOME}/terraform apply -input=false tfplan"
      }
    }
  }
}
