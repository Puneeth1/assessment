pipeline {
    agent any
    stages {
        stage('Build DEB Package') {
            steps {
                sh '''
                  
                  mkdir -p get-resources-info/DEBIAN/
                  cp control get-resources-info/DEBIAN/
                  mkdir -p get-resources-info/usr/local/bin/
                  cp get-resources-info.sh  get-resources-info/usr/local/bin/

                  chmod +x get-resources-info/usr/local/bin/get-resources-info.sh
                  dpkg-deb --build get-resources-info
                '''
            }
        }
        stage('Test DEB Package')
        {
            steps {
            sh '''
                    # Validate the package
                    # lintian get-resources-info.deb
                    
                    # List package contents
                    dpkg -c get-resources-info.deb
               '''
            }
        }
        stage('Archive DEB Artifacts') {
            steps {
                archiveArtifacts artifacts: '*.deb', fingerprint: true
            }
        }
    }
    post
    {
        always 
        {
                sh 'rm -rf get-resources-info*'
        }
    }
}
