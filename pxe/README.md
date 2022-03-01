# linux-desktop-autoinstall/pxe

## Prérequis

Les fichiers présents dans le répertoire "pxe" sont à déposer sur un serveur web (sur le serveur FOG dans notre cas). 

Dans notre cas, 

## Le répertoire "autoinstall" 

Le répertoire "autoinstall" contient les fichiers PXE qui permettent d'automatiser l'installation du système d'exploitation

Pour plus d'informations sur le fichier "user-data" > https://ubuntu.com/server/docs/install/autoinstall-reference

Il suffit de déposer le répertoire [/autoinstall/](./autoinstall/) dans le répertoire /var/www/html/ de notre serveur FOG.

Ces fichiers sont donc ensuite accessibles via une URL du type http://pxe-ubuntu/autoinstall/ubuntu/

* Notes *

Pour vérifier le bon format d'un fichier "user-data"

```
# Via cloud-init
sudo cloud-init devel schema --config-file autoinstall/ubuntu/user-data

# Via docker
./platforms/ci/check.sh
```

## Le fichier "finish-install-setup.sh"

Le fichier "finish-install-setup.sh" sera placé sur le Bureau de l'utilisateur ubuntu par défaut, il permettra de terminer la configuration du poste (certificat, outils par défaut, tunning, etc)

Dans les grandes lignes, ce fichier:
* Permet de renseigner le nom de la machine
* Télécharge le projet Git "linux-desktop-autoinstall" (le repo dans lequel vous êtes actuellement)
* Lance le playbook Ansible présent dans le répertoire "[../ansible-playbook/](../ansible-playbook/)"

Le fichier "finish-install-setup.sh" est téléchargé et placé sur le bureau de l'utilisateur par défaut à la fin de l'étape d'installation (se référer au fichier "[user-data](./autoinstall/ubuntu/user-data)")

Dans notre cas, nous avons déposé au préalable le fichier "finish-install-setup.sh" dans le répertoire /var/www/html/ de notre serveur FOG.

Ce fichier est donc ensuite accessibles via une URL du type http://pxe-ubuntu/finish-install-setup.sh


## Préparation du Boot PXE

Cette étape nécessite la mise en place d'un service PXE au préalable.

Pour des raisons de simplicité, nous avons utilisés FOG qui permet d'installer simplement tous les prérequis pour la mise en place d'un service PXE.

Une fois le service FOG opérationnel (lorqu'on arrive à démarrer un poste via le réseau et qu'on arrive à afficher le menu des entrées FOG), il est possible de préparer une nouvelle entrée dédié à l'installation de notre poste Linux.

### Préparer une nouvelle distribution

```bash
# Se connecter sur le serveur PXE
ssh pxe-ubuntu
 
# Télécharger l'iso à préparer
cd /tmp
wget https://releases.ubuntu.com/21.10/ubuntu-21.10-live-server-amd64.iso
 
# Créer (si besoin) un répertoire où l'on va monter l'iso
sudo mkdir /mnt/iso
 
# Préparation des répertoires
FOLDER_NAME=ubuntu-21.10-server
sudo mkdir /var/www/html/$FOLDER_NAME
 
# Mise à jour partage NFS
sudo vim /etc/exports
##############
...
/var/www/html/ubuntu-21.10-server *(async,no_root_squash,no_subtree_check,ro,fsid=2)
##############
 
# Redmarer le service NFS
sudo systemctl restart nfs-kernel-server
 
# Monter l'iso
sudo mount -o loop /tmp/ubuntu-21.10-live-server-amd64.iso /mnt/iso
ll /mnt/iso/
 
# Copier le répertoire de "boot"
sudo cp -r /mnt/iso/casper /var/www/html/$FOLDER_NAME
 
# Copier l'iso
sudo mv /tmp/ubuntu-21.10-live-server-amd64.iso /var/www/html/$FOLDER_NAME
chmod 777 /var/www/html/$FOLDER_NAME/ubuntu-21.10-live-server-amd64.iso
 
# Nettoyage
sudo umount /mnt/iso
```

### Mise à disposition des fichiers "autoinstall"

> Copier sur le serveur FOG le contenu du répertoire "autoinstall" dans "/var/www/html/"

### Mise à disposition du fichier "finish-install-setup.sh"

> Copier sur le serveur FOG le fichier "finish-install-setup.sh" dans "/var/www/html/"

### Créer une entrée dans le menu FOG

Se connecter à FOG > Configuration > iPXE New Menu Entry
* Menu Item: ubuntu-21.10-desktop
* Description: ubuntu-21.10-desktop
* Parameters
```
kernel http://${fog-ip}/ubuntu-21.10-server/casper/vmlinuz
initrd http://${fog-ip}/ubuntu-21.10-server/casper/initrd
imgargs vmlinuz initrd=initrd boot=casper root=/dev/ram0 ramdisk_size=2000000 ip=dhcp url=http://${fog-ip}/ubuntu-21.10-server/ubuntu-21.10-live-server-amd64.iso autoinstall ds=nocloud-net;s=http://${fog-ip}/autoinstall/ubuntu/
boot
```

### Test

A ce stade vous pouvez démarrer votre poste via le réseau, une nouvelle entrée "ubuntu-21.10-desktop" devrait apparaitre dans le menu FOG.

Il suffit de sélectionner cette entrée pour démarrer l'installation.

Une fois l'installation terminée, il est possible d'ouvrir une sessions avec l'utilisateur par défaut créé lors de l'installation.

Un fichier "finish-install-setup.sh" doit apparaitre sur le bureau de cette utilisateur afin de terminer la configuration du poste.