pipeline {
  agent {
    kubernetes {
      label 'kube-pod' // Referencing the label of the custom pod template
      defaultContainer 'pod-ubuntu-20'
    }
  }
  stages {
    stage('Run Maven and BusyBox') {
      steps {
        container('pod-ubuntu-20') {
          // Run Maven commands
          sh 'mvn -version'

          // Run BusyBox commands
          sh 'busybox --help'
        }
      }
    }
  }
}
