pipeline {
  agent any   
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('docker_id')
  }
  stages {
    stage('Build') {
      steps {
        sh 'cd image_from_jenkins'
        sh 'pwd'
        sh 'docker build -t dikodin/image_from_jenkins .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push dikodin/image_from_jenkins'
      }
    }
   stage('Pull Image') {
      steps {
        sh 'docker pull dikodin/image_from_jenkins'
      }
    }  
   stage('Run Image') {
      steps {
        sh 'docker run -id --name Hello_world_image dikodin/image_from_jenkins'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}