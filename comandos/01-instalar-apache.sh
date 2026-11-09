#!/usr/bin/env bash
# TP Integrador AySO – Virtualización con VirtualBox
# Instalación de Apache y del firewall UFW en Ubuntu Server 26.04.1 LTS
# (máquina virtual en Oracle VirtualBox 7.2, hipervisor Tipo 2).
#
# Uso, dentro de la VM:  bash 01-instalar-apache.sh

set -e

# 1. Actualizar la lista de paquetes e instalar Apache
sudo apt update
sudo apt install -y apache2

# 2. Firewall: habilitar OpenSSH ANTES de activar UFW,
#    para no perder el acceso remoto, y después Apache (puerto 80)
sudo ufw allow OpenSSH
sudo ufw allow 'Apache'
sudo ufw --force enable
sudo ufw status

# 3. Verificar que el servicio está activo
systemctl status apache2 --no-pager

# 4. Reemplazar la página por defecto por una propia
echo '<h1>TP Virtualizacion - Lua Manuel Pelus</h1><p>Servidor Apache en una VM con Ubuntu Server sobre VirtualBox</p>' \
  | sudo tee /var/www/html/index.html

# 5. Comprobar que el servidor responde
curl localhost
