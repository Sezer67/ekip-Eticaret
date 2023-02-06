# Ekip E-Ticaret


Bu proje bir e ticaret uygulamasıdır. NodeJs SQL ve EC2 teknolojilerinde kendimi geliştirmek amacıyla yapıldı.

## Açıklama


İçerisinde `React Redux AntD Tailwind Nest JWT WebSocket PostgreSql Typeorm` başta olmak üzere araçlar kullanılmıştır. Ürün anlizi SAtış analizi aylık analiz ve listeler oluşturulmaktadır.
Müşteri Satıcı Admin Rollerinde 3 farklı hesap türü mevcuttur.  
**Müşteri İşlemleri**

- Bakiye Yükleme
- Satın Alma
- Satıcıyı takip etme
- Satın Aldığı Ürünü Değerlendirme
- Yorum yapma
- Yorum yanıtlama
- Favorilere ekleme
- Takipleştiği satıcılar ile anlık chat
- Öneri Şikayet

&emsp; **Satıcı İşlemleri**

- Ürün Ekleme - Güncelleme
- Aylık Satış Grafiği
- Yıllık Satış Grafiği
- En çok satılan ürün
- Sipariş onaylama ve listeyi görüntüleme
- Müşteri ile chat
- Öneri Şikayet

&emsp; **Admin İşlemleri**

- Kullanıcı Bilgilerini görüntüleme - Freeze
- 2 tarih arası satışları görüntüleme
- Öneri Şikayet yanıt

## Kurulum


Docker ile

> docker-compose up --build  

Hazır veriler için sql dosyasını kullanma  
> Linux işletim sistemi kullanıyorsanız proje dizininde `./docker-sql-import.sh` komutunu çalıştırın.  
> Windows işletim sistemi kullanıyorsanız proje dizininde bulunan bash dosyası içerisindeki satır satır olucak şekilde komutları çalıştırın.
  
Docker Olmadan

Node Versiyonunuzu 12 ye çekin.

`cd backend && npm install`
`cd frontend && npm install`

Hazır veriler için sql dosyasını kullanma
> sql dosyasının bulunduğu dizinde terminal açın.  
> `psql -U postgres` komutu ile postgres'e bağlanın.  
> `CREATE DATABASE "ekip";`  
> `exit`   
> `psql -U postgres ekip < ekip-db.sql`  
adımlarından sonra sql verilerimiz eklenmiş olacaktır.

3 Mevcut Hesap bilgileri
| Role | username | password |
| ---- | -------- | -------- |
| admin | admin | admin1234 |
| customer | customer | ekip1234 |
| seller | seller | ekip1234|

## Project Tree

```
📦 .
├─ frontend
│  └─ src
│     ├─ assets
│     ├─ components
│     ├─ configs
│     ├─ constants
│     ├─ enums
│     ├─ helpers
│     ├─ pages
│     ├─ redux
│     ├─ service
│     ├─ types
│     ├─ axios.util.ts
│     ├─ Router.tsx
│     └─ ...
└─ backend
   ├─ src
   │  ├─ auth
   │  ├─ category
   │  ├─ chat-room
   │  ├─ comment
   │  ├─ decorators
   │  ├─ enums
   │  ├─ favorite
   │  ├─ follow
   │  ├─ idea
   │  ├─ message
   │  ├─ order
   │  ├─ product
   │  ├─ rating
   │  ├─ user
   │  ├─ app.module.ts
   │  └─ main.ts
   ├─ .env
   └─ ...
```
