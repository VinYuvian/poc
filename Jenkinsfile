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
           withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'access_key', credentialsId: 'aws_key', secretKeyVariable: 'secret_key']]) {
              // some block
              //sh "terraform plan -out=tfplan -input=false"
              sh 'terraform plan -var="aws_access_key=$access_key" -var="aws_secret_key=$secret_key"'
          }
        }
      }
    }
    stage('Terraform Apply') {
      steps {
         dir("terraform") {
          input 'Apply Plan'
           withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', accessKeyVariable: 'access_key', credentialsId: 'aws_key', secretKeyVariable: 'secret_key']]) {
              // some block
              //sh "terraform plan -out=tfplan -input=false"
              //sh 'terraform apply --auto-approve -var="aws_access_key=$access_key" -var="aws_secret_key=$secret_key"'
             script{
                env.data = readFile(file: 'inventory_temp')
               writeFile(file: 'inventory', text: ${data})  
             }
             sh 'terraform destroy --auto-approve -var="aws_access_key=$access_key" -var="aws_secret_key=$secret_key"'
          }
        }
      }
    }
    stage('Ansible playbook'){
      steps {
         dir("ansible") {
           ansiblePlaybook(
             credentialsId: 'ansible', 
             inventory: '${WORKSPACE}/terraform/inventory', 
             playbook: 'main.yaml'
           )
          }
       }
     }   
  }
}
