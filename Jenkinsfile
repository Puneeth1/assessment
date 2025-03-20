pipeline {
        agent any
            stages {
                stage('Checkout Code') {
                    steps {
                        git branch: 'main', url: 'https://github.com/Puneeth1/assessment.git'
                    }
                  }
                stage ('test') {
                    steps {
                      echo "hello"
                      sh 'pwd'
                      sh 'ls'
                    }
                  }
                }
}