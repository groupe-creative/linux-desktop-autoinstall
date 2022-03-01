# Linux Desktop Auto Install - Platforms/CI

Les fichiers présents dans le répertoire "platforms" peuvent être utilisés 
* manuellement 
* pour automatiser la vérification et le déploiement d'éléments (via Jenkins, Gitlab CI, etc)

## check.sh

Le fichier "platforms/ci/check.sh" permet de vérifier le bon format du fichier "pxe/autoinstall/ubuntu/user-data"

Utilisation
```
# On vérifie le bon format du fichier "pxe/autoinstall/ubuntu/user-data"
./platforms/ci/check.sh
```

A noter que ce fichier se base sur une image Docker pour réaliser la vérification.

## Jenkinsfile

Un fichier "Jenkinsfile" est présent à la racine du projet, il décrit de manière très succintes quelques étapes réutilisables.