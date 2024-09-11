
```python
wget -qO- https://raw.githubusercontent.com/omercanyenigun/Fractal-CAT-Protocol/main/script.sh | bash
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


