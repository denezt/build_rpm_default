node {
    try {
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
           sh "./scripts/install_prereqs.sh -ubuntu"
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
