#!/bin/bash

# Habilitar el modo estricto para capturar errores
set -e

echo "🔹 Actualizando sistema..."
sudo yum update -y

echo "🔹 Instalando Java 11..."
sudo yum install -y java-11-openjdk

echo "🔹 Instalando Docker..."
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ec2-user  # Permitir que el usuario actual use Docker

echo "🔹 Instalando Jenkins..."
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key
sudo yum install -y jenkins

echo "🔹 Iniciando Jenkins..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "🔹 Configurando permisos para Jenkins en Docker..."
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins

echo "✅ Instalación completada. Jenkins debería estar disponible en http://<TU_IP_PUBLICA>:8080"
