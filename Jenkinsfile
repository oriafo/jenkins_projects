pipeline {
  agent {
    label "first_slave_agent"
  }
  //agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('docker_id')
    CONTAINER_ID = sh (
          script: 'docker container ls --all --quiet --no-trunc --filter "name=Hello_world_image"',
          returnStdout: true
        ).trim()
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
   
    stage('Checking and getting container_Id') {
      when {
        CONTAINER_ID
      }
      steps {
        sh 'docker stop $CONTAINER_ID'
        sh 'docker rm $CONTAINER_ID'
      }
    }
    stage('Run Image') {
        sh 'docker run --entrypoint /bin/bash -id --name Hello_world_image dikodin/image_from_jenkins'
    }
    stage('Enter inside container') {
      steps {
        sh 'docker exec -i Hello_world_image /bin/bash'
      }
    }
    stage('Stop container') {
      steps {
        sh 'docker stop Hello_world_image' 
      }
    }  
  }
  //THings to work on;
  //>The Email is not working yet. work on it
  //>Try using individual working agents for each of the steps
  post {
    always {
      emailext to: "abrahamibharunujele@gmail.com",
      subject: "PIPELINE STATUS REPORT",
      body: "Good day! here is your pipeline status.",
      attachLog: true
   }
  }
}