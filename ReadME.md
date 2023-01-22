# Ekip E-Ticaret

---

Bu proje bir e ticaret uygulamasıdır. NodeJs SQL ve EC2 teknolojilerinde kendimi geliştirmek amacıyla yapıldı.

## Description

---

İçerisinde `React Redux AntD Tailwind Nest JWT WebSocket PostgreSql Typeorm` başta olmak üzere araçlar kullanılmıştır. Ürün anlizi SAtış analizi aylık analiz ve listeler oluşturulmaktadır.
Müşteri Satıcı Admin Rollerinde 3 farklı hesap türü mevcuttur.
&emsp; **Müşteri İşlemleri**

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

## Setup

---

With Docker

---

docker-compose up --build

hazır sql datası için
Linux de
docker-sql-import.sh dosyasını çalıştırın
Windows da sh içerisindeki adımları container çalışırken çalıştırın.

Without Docker

---

bu ksımı ahmetle dene
use to node:12
indireceğiniz dizinde terminal açıp `git clone url` press enter yapıonız.
`cd backend && npm install`
`cd frontend && npm install`
I use to version 13 of postgresql;
Create Database "ekip"
`pg_dump -U postgres ekip << sqlfile`
artık çalıştırabilirsiniz.
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
