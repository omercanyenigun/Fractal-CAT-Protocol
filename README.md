
```python
sudo apt update && sudo apt upgrade -y
sudo apt install make clang pkg-config libssl-dev build-essential git screen protobuf-compiler -y
```

```python
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
```

```python
sudo apt install docker.io -y
sudo systemctl status docker
docker --version
```

```python
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
```

```python
sudo apt-get install -y nodejs
```

```python
sudo apt install -y nodejs npm
nodejs --version
```

```python
sudo npm install -g yarn
```

```python
yarn install
```


```python
git clone https://github.com/CATProtocol/cat-token-box.git
```

```python
cd cat-token-box
```

```python
yarn install && yarn build
```


```python
cd packages/tracker
```

```python
sudo chmod 777 docker/data
sudo chmod 777 docker/pgdata
```

```python
docker-compose up -d
```


```python
cd ../../ && docker build -t tracker:latest .
```

```python
docker run -d \
    --name tracker \
    --add-host="host.docker.internal:host-gateway" \
    -e DATABASE_HOST="host.docker.internal" \
    -e RPC_HOST="host.docker.internal" \
    -p 3000:3000 \
    tracker:latest
```


Synced Kontrol 

```python
curl http://127.0.0.1:3000/api
```

Synced olduktan sonra


```python
yarn cli wallet create
```

```python
yarn cli wallet address
```


Cüzdana FB token gönder


Mint

```python
yarn cli mint -i 45ee725c2c5993b3e4d308842d87e973bf1951f5f7a804b21e4dd964ecd12d6b_0 5 --fee-rate 500
```



Balance Kontrol 

```python
yarn cli wallet balances
```


Scprit

```python
sceen -S cat
```

```python
cd
cd cat-token-box/packages/cli
```

```python
nano script.sh
```

```python
#!/bin/bash

# Her 180 saniyede bir çalışacak döngü
while true; do
    # İlgili komutu çalıştır
    yarn cli mint -i 45ee725c2c5993b3e4d308842d87e973bf1951f5f7a804b21e4dd964ecd12d6b_0 5 --fee-rate 500

    # 180 saniye bekle
    sleep 180
done
```

```python
chmod +x script.sh
```

```python
./script.sh
```


