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
		echo "Executing RPMBUILD..."
		sh "sudo ./scripts/build_rpm.sh"
        }

        stage('Testing') {
		echo 'Testing'
		sh "sudo ./scripts/test_rpm.sh"		
        }

        stage('Deploy') {
		echo 'Deploy Stage'
		sh "./scripts/deploy_to_location.sh"
        }
  } catch (e) {
	currentBuild.result = "FAILED"
	throw e
  } finally {
	echo 'Success'
  }
}
