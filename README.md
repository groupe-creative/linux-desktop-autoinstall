# Linux Desktop Autoinstall

Ce projet contient les éléments nécessaires pour automatiser l'installation d'Ubuntu Desktop en entreprise.

Il fait partie intégrante d'un article dédié à ce sujet : https://blog.groupe-creative.fr/deployer-des-postes-de-dev-ubuntu/

## Partie 1 - Installation automatisée d'Ubuntu Desktop

Cette étape permet de réaliser l'installation d'une distribution "Ubuntu Desktop" sans intervention humaine

Toutes les sections "interactives" que l'on doit renseigner lors d'une installation manuelle sont préconfigurées.

* [Voir la documentation](./pxe/)

## Partie 2 - Terminer la configuration

Cette étape permet de terminer la configuration du poste une fois le système d'exploitation installé.

La configuration du poste sera réalisée principalement à l'aide d'Ansible.

* [Voir la documentation](./ansible-playbook/)

## Partie 3 (facultatif) - CI / CD

Cette étape permet de tester les modifications apportées à ce repository et de déployer les fichiers qui le nécessitent au bon endroit.

* [Voir la documentation](./platforms/)
