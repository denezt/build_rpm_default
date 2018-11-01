node {
	try {
		stage('Prereqs') {
		// To be added to shared libraries" 
		echo "==================[ PREQS ]=================="
		sh "echo \"Logged in as user: $USER\""
        }
        stage('Checkout') {
		// To be added to shared libraries
		echo "==================[ CHECKOUT - SOURCE CODE ]=================="
		checkout scm           
	}
        
        stage('Clean') {
		echo "==================[ CLEAN SESSIONS ]=================="
		sh "sudo ./scripts/create_build_user.sh --clean"
        }
        
        stage('Build') {
		echo "==================[ BUILD RPM ]=================="
		sh "sudo ./scripts/create_build_user.sh --build"
		sh "sudo ./scripts/install_prereqs.sh"
		sh "cd /home/build/displaymsg-1.0; sudo rpmbuild -ba displaymsg.spec"
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
