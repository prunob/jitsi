#!/bin/bash

# Mise à jour du système
apt update
apt upgrade -y

# Instalation des prérequis
apt install -y \
     software-properties-common \
     curl \
     wget \
     gnupg2 \
     git \
     apt-transport-https \
     ca-certificates \
     fontconfig \
     locales \
     tzdata

# Ajout du dépôt Jitsi
echo "deb https://download.jitsi.org stable/" | tee /etc/apt/sources.list.d/jitsi-stable.list
wget -qO -  https://download.jitsi.org/jitsi-key.gpg.key | apt-key add -

# Installation de Jitsi
apt update
apt install -y jitsi-meet

# Configuration de Jitsi
echo "set jitsi-videobridge/jvb-hostname $HOSTNAME" | debconf-set-selections
echo "set jitsi-meet/cert-choice=Self-signed certificate" | debconf-set-selections
dpkg-reconfigure -f noninteractive jitsi-meet

# Redémarrage des services
systemctl restart jitsi-videobridge2
systemctl restart jicofo
systemctl restart nginx