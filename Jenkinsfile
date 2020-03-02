pipeline {
    
    environment {
    registry = "rk90229/fmy-project"
    registryCredential = 'mydockerhub'
    dockerImage = ''
    }
    
    tools {
        jdk 'MyJava'
        maven 'MyMaven'
        
    }
   agent any

   stages {
      stage('Checkout') {
         steps {
            echo 'git checkout'
            git 'https://github.com/rk280392/MyCICDProject.git'
         }
      }
      stage('Compile') {
          steps {
              echo 'compiling my code'
              sh 'mvn compile'
          }
      }
      stage('CodeReview') {
          steps {
              echo 'Reviewing code'
              sh 'mvn pmd:pmd'
          }
          post {
              always {
                  pmd pattern: 'target/pmd.xml'
              }
          }
      }
      stage('UnitTest') {
          steps {
              echo 'Doing unit test'
              sh 'mvn test'
          }
      }
      stage('MatricCheck') {
          steps {
              echo 'Doing matric check'
              sh 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
          }
          post {
              always {
                  cobertura coberturaReportFile: 'target/site/cobertura/coverage.xml'
              }
          }
      }
      stage ('Package') {
          steps {
              echo 'Packing .war file'
              sh 'mvn package'
          }
      }
      stage ('DockerInstall') {
          steps {
              echo 'Installing docker'
              sh './installing_docker.sh'
          }
      }
      stage('Building image') {
      steps{
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
      }
    }
    stage('Deploy Image') {
      steps{
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }
      }
    }
  }
}
