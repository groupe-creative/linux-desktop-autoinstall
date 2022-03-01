#!/bin/bash

set -e
DEBIAN_FRONTEND=noninteractive

# Initialisation des répertoires
mkdir -p /tmp/install
sudo rm -rf /tmp/install/*
sudo chmod 777 -R /tmp/install
cd /tmp/install

# Saisie du nom du PC
read -p "Nom du PC: " pc_name

# Start Chrono
START=$(date +%s)

# Redémarrage de services qui en ont besoin suite à l'upgrade
sudo needrestart -ra

# Installation d'Ansible
sudo apt install -y software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install -y python3 python3-pip ansible

# Installation du playbook de configuration du poste
git clone https://github.com/groupe-creative/linux-desktop-autoinstall.git
cd /tmp/install/linux-desktop-autoinstall/ansible-playbook
ansible-playbook -u ubuntu linux-desktop-init.yml --connection=local --extra-vars "pc_name=$pc_name"

# Suppression des fichiers d'installation
cd /tmp
sudo rm -rf /tmp/install
sudo rm -rf /etc/skel/Bureau/finish-install-setup.sh

# Stop Chrono
END=$(date +%s)
DIFF=$(( $END - $START ))
echo "Execution Time: $DIFF seconds"

# Redémarrage du poste
read -p "Press enter to reboot"
reboot