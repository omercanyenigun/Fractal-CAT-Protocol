#!/bin/bash

# Sistem güncellemeleri
echo "Sistem güncellemeleri yapılıyor..."
sudo apt update && sudo apt upgrade -y

# Gerekli paketlerin yüklenmesi
echo "Gerekli paketler yükleniyor..."
sudo apt install make clang pkg-config libssl-dev build-essential git screen protobuf-compiler -y

# Docker kurulumu
echo "Docker kurulumu yapılıyor..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Node.js kurulumu
echo "Node.js kurulumu yapılıyor..."
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# Docker için gerekli ek paketler yükleniyor
echo "Docker ek paketleri yükleniyor..."
sudo apt install docker.io -y

# Docker Compose kurulumu
echo "Docker Compose kurulumu yapılıyor..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Node.js ve npm kurulumu
echo "Node.js ve npm kurulumu yapılıyor..."
sudo apt-get install -y nodejs
sudo apt install -y nodejs npm
nodejs --version

# Yarn kurulumu
echo "Yarn kurulumu yapılıyor..."
sudo npm install -g yarn
yarn install

# CAT Protocol projesinin klonlanması
echo "CAT Protocol projesi klonlanıyor..."
git clone https://github.com/CATProtocol/cat-token-box.git

# Proje dizinine geçiş ve kurulumu
cd cat-token-box
echo "Proje kurulumu yapılıyor..."
yarn install && yarn build

# Docker dosyaları için izinlerin ayarlanması
cd packages/tracker
echo "Docker dosyaları için izinler ayarlanıyor..."
sudo chmod 777 docker/data
sudo chmod 777 docker/pgdata

# Docker Compose çalıştırılması
echo "Docker Compose başlatılıyor..."
docker-compose up -d

# Ana dizine dönüp Docker image oluşturulması
cd ../../
echo "Docker image oluşturuluyor..."
docker build -t tracker:latest .

# Docker container çalıştırılması
echo "Tracker container başlatılıyor..."
docker run -d \
    --name tracker \
    --add-host="host.docker.internal:host-gateway" \
    -e DATABASE_HOST="host.docker.internal" \
    -e RPC_HOST="host.docker.internal" \
    -p 3000:3000 \
    tracker:latest

# Synced Kontrol
echo "Synced kontrol yapılıyor..."
curl http://127.0.0.1:3000/api
