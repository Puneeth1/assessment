// pipeline {
//         agent any
//             stages {
//                 stage('Checkout Code') {
//                     steps {
//                         git branch: 'main', url: 'https://github.com/Puneeth1/assessment.git'
//                     }
//                   }
//                 stage ('test') {
//                     steps {
//                       echo "hello"
//                       sh 'pwd'
//                       sh 'ls'
//                     }
//                   }
//                 }
// }

pipeline {
    agent any
    stages {
        // stage('Install Dependencies') {
        //     steps
        //     {
        //         sh 'apt-get install lintian'
        //     }
        // }
        stage('Build DEB Package') {
            steps {
                sh '''
                  
                  mkdir -p get-resources-info/DEBIAN/

                  cat << EOF > get-resources-info/DEBIAN/control
Package: get-resources-info
Version: 1.0
Architecture: all
Maintainer: Devatha Naga Puneeth
Description: A script to collect system data using gum

EOF
                mkdir -p get-resources-info/usr/local/bin/

                cat << EOF > get-resources-info/usr/local/bin/get_resources_info.sh
#!/bin/bash

# Options that are available to the users
CHOICES=$(gum choose --no-limit "RAM Usage" "CPU Usage" "Disk Free Space" "Network Info")

# Looping through the user selected choices
while read -r choice; do
   case "$choice" in
   "RAM Usage")
      gum style --bold "RAM Usage"
      free -h ; echo # added echo to add a newline after printing the output of the command
      ;;
   "CPU Usage")
      gum style --bold "CPU Usage"
      top -bn ; echo
      ;;
   "Disk Free Space")
      gum style --bold "Disk Free Space"
      df -h ; echo
      ;;
   "Network Info")
      gum style --bold "Network Info"
      ip a ; echo
      ;;
   esac
done <<< $CHOICES

exit 0
EOF
                chmod +x get-resources-info/usr/local/bin/get_resources_info.sh
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
