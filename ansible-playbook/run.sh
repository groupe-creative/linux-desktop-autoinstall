#!/bin/bash

# Saisie du nom du PC
read -p "Nom du PC: " pc_name

# On lance le playbook
ansible-playbook -u ubuntu linux-desktop-init.yml --connection=local --extra-vars "pc_name=$pc_name"
