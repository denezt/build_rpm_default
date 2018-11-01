node {
	echo "BUILD_NUMBER ${BUILD_NUMBER}"
	echo "BUILD_ID  ${BUILD_ID}"
	echo "JOB_NAME ${JOB_NAME}"

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
 
        stage('Create User') {
		echo "==================[ CREATE SESSION USER ]=================="
		sh "sudo ./scripts/create_build_user.sh --build"
		sh "sudo ./scripts/install_prereqs.sh"
        }

        stage('Build') {
		echo "==================[ BUILD RPM ]=================="
		sh "pwd"
		sh "ls -lsaR scripts"
		sh "cat ./scripts/build_rpm.sh | bash -s"
        }

        stage('Testing') {
		echo "==================[ TESTING PACKAGE ]=================="
		sh "pwd"
		sh "cat ./scripts/test_rpm.sh | bash -s"
        }

	if (!"${JOB_NAME}".endsWith("_check")) {
		stage('Deploy') {
			echo "==================[ DEPLOYING ]=================="
			sh "pwd"
			sh "cat ./scripts/deploy_to_location.sh | bash -s" 
		}
	}
  } catch (e) {
	currentBuild.result = "FAILED"
	throw e
  } finally {
	echo 'Success'
  }
}
