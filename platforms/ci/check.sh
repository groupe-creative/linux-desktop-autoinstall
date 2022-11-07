#!/bin/bash

set -x

# Préparation de l'image Docker utilisée pour la vérification
docker build -f platforms/dockerfiles/cloud-init/20.04/Dockerfile -t cloud-init:dev .

# Nom de l'image Docker à utiliser
DOCKER_IMAGE="cloud-init:dev"
# Commande pour vérifier le format du fichier "user-data"
CMD="cloud-init schema --config-file pxe/autoinstall/ubuntu/user-data"

# Check du fichier "user-data"
docker run --rm -w /code -v $PWD:/code $DOCKER_IMAGE //bin/bash -c "$CMD"
