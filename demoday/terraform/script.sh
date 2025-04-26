#!/usr/bin/env bash

# Configuração das variáveis
EFS_ID="${EFS_ID}"
WORDPRESS_DB_HOST="${WORDPRESS_DB_HOST}"
WORDPRESS_DB_USER="${WORDPRESS_DB_USER}"
WORDPRESS_DB_PASSWORD="${WORDPRESS_DB_PASSWORD}"
WORDPRESS_DB_NAME="${WORDPRESS_DB_NAME}"

# Atualiza os pacotes e instala pacotes:
echo "[userdata.sh] Updating packages..."
sudo apt update && sudo apt upgrade -y && sudo apt install -y jq unzip
echo "[userdata.sh] Updated packages!"

# Instalando Docker Engine utilizando APT
# https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository

echo "[userdata.sh] Starting Docker installation..."

## Adiciona a chave 'GPG' do Docker:
echo "[userdata.sh] Setting up Docker APT repository..."
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "[userdata.sh] Done! The Docker repository is now configured."

## Adiciona o repositório ao APT sources:
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

## Instala os pacotes necessários para o Docker:
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

## Testando a instalação:
if ! docker --version > /dev/null 2>&1; then echo "[userdata.sh] Something went wrong! Docker isn't running."; exit 1; fi
if ! docker compose version > /dev/null 2>&1; then echo "[userdata.sh] Something went wrong! Docker compose isn't running."; exit 1; fi

echo "[userdata.sh] Done! The Docker is now installed."

# Configurando a inicialização do Docker e suas permissões (post install):
# https://docs.docker.com/engine/install/linux-postinstall/

## Atualiza as permissões:
echo "[userdata.sh] Setting up Docker permissions..."
sudo groupadd docker 2>/dev/null # ignore if group already exists
sudo usermod -aG docker $USER
#newgrp docker # activate the changes to groups
echo "[userdata.sh] Done! The Docker permissions is now configured."

## Inicia o serviço do Docker:
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
echo "[userdata.sh] Enabled Docker and Containerd services!"
echo "[userdata.sh] Use 'sudo systemctl status docker.service' to see the current status."

# Configuração do EFS:
echo "[userdata.sh] Setting up EFS, installing 'nfs-common'..."
sudo apt install nfs-common -y
sudo mkdir -p /mnt/efs
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport "$EFS_ID":/ /mnt/efs
echo "[userdata.sh] Done! The EFS is now configured at '/efs'"

# Cria e configura o arquivo 'compose.yaml':
COMPOSE_PATH="/opt/wordpress"
WORDPRESS_PATH="/mnt/efs/wordpress"
mkdir -p "$COMPOSE_PATH"  # create the directory

cat << EOF > "$COMPOSE_PATH/compose.yaml"
services:
  wordpress:
    image: wordpress
    restart: always
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: "$WORDPRESS_DB_HOST"
      WORDPRESS_DB_USER: "$WORDPRESS_DB_USER"
      WORDPRESS_DB_PASSWORD: "$WORDPRESS_DB_PASSWORD"
      WORDPRESS_DB_NAME: "$WORDPRESS_DB_NAME"
    volumes:
      - "$WORDPRESS_PATH:/var/www/html"
EOF
echo "[userdata.sh] Compose file created at '$COMPOSE_PATH/compose.yaml'!"

# Converte o Wordpress em um Service:
SERVICE_PATH="/etc/systemd/system"
echo "[userdata.sh] Creating wordpress service file..."
cat << EOF | sudo tee "$SERVICE_PATH/wordpress.service"
[Unit]
Description=WordPress Service
After=docker.service
Requires=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker compose -f $COMPOSE_PATH/compose.yaml up -d
 
[Install]
WantedBy=multi-user.target
EOF
echo "[userdata.sh] Wordpress service file created at '$SERVICE_PATH/wordpress.service'!"

# Configura wordpress.service usando systemctl:
sudo systemctl enable wordpress.service
sudo systemctl start wordpress.service
echo "[userdata.sh] Wordpress service enabled using 'systemctl'!"

# Finaliza
echo ""
echo "[userdata.sh] Wordpress has installed with success! Verify the status using 'sudo systemctl status wordpress.service'"