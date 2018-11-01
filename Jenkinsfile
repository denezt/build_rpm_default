node {
    try {
        stage('Prereqs') {
              // To be added to shared libraries
              sh "whoami"
        }
        stage('Checkout') {
              // To be added to shared libraries
              checkout scm           
        }
        
        stage('Clean') {
            sh "ls -l"
            sh "ls -l scripts > test.file"
        }
        
        stage('Build') {
           echo 'Build'    
           sh 'sudo ./scripts/create_build_user.sh -start'
           sh 'sudo ./scripts/install_prereqs.sh -ubuntu
        }

        stage('Testing') {
            echo 'Testing'
        }

        stage('Staging') {
            echo 'Deploy Stage'
        }
        stage('Deploy') {
            echo 'Deploy Stage'
        }
  } catch (e) {
    currentBuild.result = "FAILED"
    throw e
  } finally {
    echo 'Success'
  }
}
