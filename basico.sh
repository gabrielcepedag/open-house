

#!/usr/bin/env bash
echo "Instalando estructura basica para clase virtualhost y proxy reverso"

# Habilitando la memoria de intecambio.
sudo dd if=/dev/zero of=/swapfile count=2048 bs=1MiB
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

# Instando los software necesarios para probar el concepto.
sudo yum update -y && sudo yum install -y htop nmap git httpd mod_ssl tree

# Dependencias necesarias para instalar cerbort
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum install -y certbot

# Instalando la versión sdkman y java
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java

# Subiendo el servicio de Apache.
sudo systemctl start httpd


# Clonando el proyecto copiando los archivos importantes.
# Una vez compiado, si es reiniciado el servicio de apache, deberá configurar los nuevos archivos creados.
# Donde dice cambiar sustituir.
cd ~/
git clone https://github.com/gabrielcepedag/open-house.git && cd open-house/
sudo cp seguro.conf /etc/httpd/conf.d/
sudo cp proxyreverso.conf /etc/httpd/conf.d/

sudo systemctl reload httpd

# Clonando el proyecto de Javalin-demo e iniciando la aplicación, escuchando en el puerto 7003
cd ~/
git clone https://github.com/darvybm/CarrerasPOS.git
echo "Script completado!..."
