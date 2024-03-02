node {
	echo "BUILD_NUMBER ${BUILD_NUMBER}"
	echo "BUILD_ID  ${BUILD_ID}"
	echo "JOB_NAME ${JOB_NAME}"

	try {

		stage('Checkout') {
			// To be added to shared libraries
			sh "sudo apt-get install git -y"
			echo "==================[ CHECKOUT - SOURCE CODE ]=================="
			checkout scm
			sh "pwd"
			sh "sudo chmod -R 777 scripts"
			sh "ls -lsaR scripts"
		}

		stage('Prereqs') {
			// To be added to shared libraries"
			echo "==================[ PREQS ]=================="
			sh "echo \"Logged in as user: $USER\""
			sh "sudo ./scripts/install_prereqs.sh"
		}

		stage('Clean') {
			echo "==================[ CLEAN SESSIONS ]=================="
			sh "sudo ./scripts/create_build_user.sh --clean"
		}

		stage('Create User') {
			echo "==================[ CREATE SESSION USER ]=================="
			sh "sudo ./scripts/create_build_user.sh --build $JENKINS_PASSWORD"
		}

		stage('Build') {
			echo "==================[ BUILD RPM ]=================="
			sh "pwd"
			sh "sudo ./scripts/build_rpm.sh"
		}

		stage('Testing') {
			echo "==================[ TESTING PACKAGE ]=================="
			sh "pwd"
			// sh "sudo ./scripts/test_rpm.sh"
		}

			if (!"${JOB_NAME}".endsWith("_check")) {
				stage('Deploy') {
					echo "==================[ DEPLOYING ]=================="
					sh "pwd"
					sh "sudo ./scripts/deploy_to_location.sh"
				}
			}
		} catch (e) {
			currentBuild.result = "FAILED"
			throw e
		} finally {
				echo 'Success'
		}
}
