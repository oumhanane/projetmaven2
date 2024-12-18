 pipeline {
   agent any
   stages {
	stage("checkout"){
	steps {
	echo "récupération du projet"
	git branch: 'main',
	credentialsId: 'jenkins_github',
	url: 'git@github.com:oumhanane/projetmaven2.git' 
	}
	}
	stage("compile"){
	steps{
	echo "compilation du projet"
	sh './mvnw compile'
	}
	}
	stage("tests"){
	steps{
	echo "test unitaire et test d'intégration"
	sh './mvnw test'
	}
	}
	stage("package"){
	steps{
	echo "création du package de l'application"
	sh './mvnw package'
	}
	}
	stage("image docker"){
	steps{
	echo "création de l'image docker"
	sh 'docker build -t registry.gretadevops.com:5000/calculatorbis .'
	}
	}
	stage("push registry"){
	steps{
	echo "push de l'image sur le registry"
	sh 'docker push registry.gretadevops.com:5000/calculatorbis'
	}
	}

	stage("test du deploiement"){
	steps{
	echo "déploiement de l'application"	
		}
	}
   }
       post {
        always {
            echo "this always happen"
            sh 'docker rm -f calculatortest 2>/dev/null'
        }
        failure {
            mail to: "thomas.lepetit1990@gmail.com",
            subject: "this pipeline failed.",
            body: "you're a failure."
        }
    }
}
