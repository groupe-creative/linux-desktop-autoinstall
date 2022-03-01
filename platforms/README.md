# linux-desktop-autoinstall/platforms

Les fichiers présents dans le répertoire "platforms" peuvent être utilisés 
* manuellement 
* pour automatiser la vérification et le déploiement d'éléments (via Jenkins, Gitlab CI, etc)

## Le répertoire "platforms/ci" 

### "platforms/ci/check.sh"

Permet de vérifier le bon format du fichier "pxe/autoinstall/ubuntu/user-data"

Utilisation
```
# On vérifie le bon format du fichier "pxe/autoinstall/ubuntu/user-data"
./platforms/ci/check.sh
```

A noter que ce fichier se base sur une image Docker pour réaliser la vérification.

## Le répertoire "platforms/dockerfiles"

Ce répertoire contient les différents fichiers Dockerfile utile à ce projet.

### "platforms/dockerfiles/cloud-init/"

L'image Docker "cloud-init" est utilisée par le script "./platforms/ci/check.sh"

#### Builder l'image Docker</b>

```
cd platforms/dockerfiles/cloud-init/20.04
docker build -t cloud-init:dev .
```

#### Pour pusher / taguer l'image Docker</b>
```
# Se logguer sur le Registry privé (à faire une seule fois par session)
docker login my-private-registry:xxxxx

# Tagguer l'image
docker tag cloud-init:dev my-private-registry:xxxxx/cloud-init:20.04
 
# Pusher l'image
docker push my-private-registry:xxxxx/cloud-init:20.04
```