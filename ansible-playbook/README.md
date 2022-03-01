# linux-desktop-autoinstall/ansible-playbook

Ce répertoire contient un playbook Ansible qui sera exécuté suite à l'installation du système d'exploitation.

## Variables à modifier

Variables pour la connexion avec l'Active Directory
> [linux-desktop-ad-auth](./ansible-playbook/roles/linux-desktop-ad-auth/vars/)

Variables spécifiques Infrastructure
> [linux-desktop-configure](./ansible-playbook/roles/linux-desktop-configure/vars/)


## Exemple d'utilisation
```
cd ansible-playbook
./run.sh
```

## Détails

Ce playbook Ansible réalise les actions suivantes:

* Mise à jour du fichier /etc/hosts
* Ajout du PC dans le domaine
* Configuration de l'authentification des utilisateurs via un Active Directory
* Installation de packages par défaut (Microsoft Teams, TeamViewers, Docker, etc.)
* Configuration complémentaires (réseau, droits, etc)
