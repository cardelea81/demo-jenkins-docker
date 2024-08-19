pipeline {
	agent none
:	environment {
		QUAY_REPO = 'quay.io/dotronglong/go-demo'
		QUAY_REPO_TAG = 'latest'
    }
	stages {
		stage('CheckOut') {
			agent { label 'master' }
			steps {
				checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/dotronglong/demo-jenkins-docker.git']]])
			}
		}
		stage('Prepare') {
			agent { label 'master' }
			steps {
				sh 'make get-go.sh'
			}
		}
		stage('ResolveDependencies') {
			agent { label 'master' }
			steps {
				script {
					docker.image('golang:1.9').inside('') {
						sh 'make deps'
					}
				}
			}
		}
		stage('TestUnit') {
			agent { label 'master' }
			steps {
				script {
					docker.image('golang:1.9').inside('-v $WORKSPACE:/go/src/demo-jenkins-docker') {
                        sh '''
                        cd /go/src/demo-jenkins-docker
                        make test
                        '''
	                }
				}
			}
		}
		stage('Build') {
			agent { label 'master' }
			steps {
				script {
					docker.image('golang:1.9').inside('') {
						sh 'make build'
					}
				}
			}
		}
		stage('Deploy') {
			agent { label 'master' }
			steps {
				script {
					withDockerRegistry([credentialsId: 'quay-io-bot', url: 'https://quay.io']) {
	                    docker.build('$QUAY_REPO:$QUAY_REPO_TAG', '-f Dockerfile .').push('latest')
	                }
	                sh 'docker rmi -f $QUAY_REPO:$QUAY_REPO_TAG'
                }
			}
			post {
				always {
					deleteDir()
				}
			}
		}
	}
}
