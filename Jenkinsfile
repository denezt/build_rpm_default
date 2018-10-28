node {
    try {
        stage('Checkout') {
              // To be added to shared libraries
              checkout scm            
        }
        
        stage('Clean') {
            sh "ls -l"
            sh "ls -l scripts"
        }
        
        stage('Build') {
           echo 'Build'            
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
