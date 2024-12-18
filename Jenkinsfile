pipeline {
    agent any
    stages {
        stage("checkout") {
            steps {
                echo "Récupération du projet"
                git branch: 'main',
                credentialsId: 'jenkins_github',
                url: 'git@github.com:oumhanane/projetmaven2.git'
            }
        }
        stage("compile") {
            steps {
                echo "Compilation du projet"
                sh './mvnw compile'
            }
        }
        stage("tests") {
            steps {
                echo "Tests unitaires et tests d'intégration"
                sh './mvnw test'
            }
        }
        stage("package") {
            steps {
                echo "Création du package de l'application"
                sh './mvnw package'
            }
        }
        stage("image docker") {
            steps {
                echo "Création de l'image Docker"
                sh 'docker build -t registry.gretadevops.com:5000/calculatorbis .'
            }
        }
        stage("push to Docker Hub") {
            steps {
                echo "Push de l'image vers Docker Hub"
                script {
                    // Authentification avec Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh '''
                            echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin
                            docker tag registry.gretadevops.com:5000/calculatorbis $DOCKER_USERNAME/calculatorbis:latest
                            docker push $DOCKER_USERNAME/calculatorbis:latest
                        '''
                    }
                }
            }
        }
        stage("test du déploiement") {
            steps {
                echo "Déploiement de l'application"
                // Ajouter ici les étapes pour le déploiement, si nécessaire
            }
        }
    }
    post {
        always {
            echo "Cela se produit toujours"
            sh 'docker rm -f calculatortest 2>/dev/null'
        }
        failure {
            mail to: "oum.hanane@gmail.com",
            subject: "Le pipeline a échoué",
            body: "Une erreur s'est produite lors de l'exécution du pipeline."
        }
    }
}
