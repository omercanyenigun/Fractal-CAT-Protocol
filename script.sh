#!/bin/bash

# Renk kodları
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

# Sistem güncellemeleri
echo -e "${ORANGE}Sistem güncellemeleri yapılıyor...${NC}"
sudo apt update && sudo apt upgrade -y

# Gerekli paketlerin yüklenmesi
echo -e "${ORANGE}Gerekli paketler yükleniyor...${NC}"
sudo apt install make clang pkg-config libssl-dev build-essential git screen protobuf-compiler -y

# Docker kurulumu
echo -e "${ORANGE}Docker kurulumu yapılıyor...${NC}"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y

# Node.js kurulumu
echo -e "${ORANGE}Node.js kurulumu yapılıyor...${NC}"
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -

# Docker için gerekli ek paketler yükleniyor
echo -e "${ORANGE}Docker ek paketleri yükleniyor...${NC}"
sudo apt install docker.io -y

# Docker Compose kurulumu
echo -e "${ORANGE}Docker Compose kurulumu yapılıyor...${NC}"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Node.js ve npm kurulumu
echo -e "${ORANGE}Node.js ve npm kurulumu yapılıyor...${NC}"
sudo apt-get install -y nodejs
sudo apt install -y nodejs npm
nodejs --version

# Yarn kurulumu
echo -e "${ORANGE}Yarn kurulumu yapılıyor...${NC}"
sudo npm install -g yarn
yarn install

# CAT Protocol projesinin klonlanması
echo -e "${ORANGE}CAT Protocol projesi klonlanıyor...${NC}"
git clone https://github.com/CATProtocol/cat-token-box.git

# Proje dizinine geçiş ve kurulumu
cd cat-token-box
echo -e "${ORANGE}Proje kurulumu yapılıyor...${NC}"
yarn install && yarn build

# Docker dosyaları için izinlerin ayarlanması
cd packages/tracker
echo -e "${ORANGE}Docker dosyaları için izinler ayarlanıyor...${NC}"
sudo chmod 777 docker/data
sudo chmod 777 docker/pgdata

# Docker Compose çalıştırılması
echo -e "${ORANGE}Docker Compose başlatılıyor...${NC}"
docker-compose up -d

# Ana dizine dönüp Docker image oluşturulması
cd ../../
echo -e "${ORANGE}Docker image oluşturuluyor...${NC}"
docker build -t tracker:latest .

# Docker container çalıştırılması
echo -e "${ORANGE}Tracker container başlatılıyor...${NC}"
docker run -d \
    --name tracker \
    --add-host="host.docker.internal:host-gateway" \
    -e DATABASE_HOST="host.docker.internal" \
    -e RPC_HOST="host.docker.internal" \
    -p 3000:3000 \
    tracker:latest

# Synced Kontrol
echo -e "${ORANGE}Synced kontrol yapılıyor...${NC}"
curl http://127.0.0.1:3000/api
