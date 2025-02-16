#!/bin/bash

# [setup.sh](http://setup.sh/): Instala Docker y Docker Compose en la instancia.

# Ejecuta este script en la instancia (por ejemplo, con: bash [setup.sh](http://setup.sh/))

# Asegúrate de tener permisos de sudo.

set -e

echo "Detectando gestor de paquetes..."

# Detectar el gestor de paquetes

if command -v yum >/dev/null 2>&1; then
PM="yum"
elif command -v apt-get >/dev/null 2>&1; then
PM="apt-get"
else
echo "No se encontró un gestor de paquetes compatible (yum o apt-get)."
exit 1
fi

echo "Usando el gestor de paquetes: $PM"

if [ "$PM" = "yum" ]; then
echo "Actualizando el sistema..."
sudo yum update -y

```
echo "Instalando Docker..."
sudo yum install -y docker

echo "Iniciando y habilitando Docker..."
sudo systemctl start docker
sudo systemctl enable docker

```

elif [ "$PM" = "apt-get" ]; then
echo "Actualizando el sistema..."
sudo apt-get update -y

```
echo "Instalando Docker..."
sudo apt-get install -y docker.io

echo "Iniciando y habilitando Docker..."
sudo systemctl start docker
sudo systemctl enable docker

```

fi

echo "Instalando Docker Compose..."

# Obtener la última versión de Docker Compose desde GitHub

DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -oP '"tag_name": "\K(.*)(?=")')
echo "Versión detectada: $DOCKER_COMPOSE_VERSION"

sudo curl -L "[https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$](https://github.com/docker/compose/releases/download/$%7BDOCKER_COMPOSE_VERSION%7D/docker-compose-$)(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "Docker Compose instalado: $(docker-compose --version)"

# Agregar el usuario actual al grupo docker (para usar docker sin sudo)

if ! groups "$USER" | grep -q "\bdocker\b"; then
echo "Agregando el usuario '$USER' al grupo docker..."
sudo usermod -aG docker "$USER"
echo "Por favor, reinicia tu sesión para que los cambios tengan efecto."
fi

echo "¡Instalación completada!"