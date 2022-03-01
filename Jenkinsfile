// Prérequis
// Depuis le serveur Jenkins, copier la clé de l'utilisateur cible pour réaliser des actions ssh sans saisir de mot de passe
// sudo su jenkins
// ssh-copy-id user@pxe-ubuntu
node() {
    try {
        stage('Prepare') {
            checkout scm
            sh("chmod 777 -R .")
        }

        stage('Check') {
            // Vérification du fichier "user-data"
            sh("./platforms/ci/check.sh")
        }

        stage("Deploy") {
            // Copie du répertoire "autoinstall"
            sh("scp -r -o StrictHostKeyChecking no pxe/autoinstall user@pxe-ubuntu:/var/www/html")
            sh("ssh -o StrictHostKeyChecking=no user@pxe-ubuntu sudo chmod 777 -R /var/www/html/autoinstall")

            // Copie du fichier  "finish-install-setup.sh"
            sh("scp -o StrictHostKeyChecking no pxe/finish-install-setup.sh user@pxe-ubuntu:/var/www/html/finish-install-setup.sh")
            sh("ssh -o StrictHostKeyChecking=no user@pxe-ubuntu sudo chmod 777 -R /var/www/html/finish-install-setup.sh")
        }
    } catch (err) {
        echo(err.dump())
    }
}
