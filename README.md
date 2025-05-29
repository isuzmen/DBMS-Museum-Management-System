# 🎨 VTYS - Müze Yönetim Sistemi Veritabanı Projesi

Bu proje, SQL Server üzerinde geliştirilmiş bir Müze Yönetim Sistemi Veritabanı Tasarımıdır. Projede müzeler, eserler, sanatçılar, personel, ziyaretçiler, bilet türleri ve transfer kayıtları gibi birçok varlık modellenmiş ve aralarındaki ilişkiler detaylı biçimde yapılandırılmıştır.

---

## 🗂️ Proje İçeriği

| Dosya Adı              | Açıklama                                      |
|------------------------|-----------------------------------------------|
| `creation (3).sql`    | Veritabanı tablolarının oluşturulması         |
| `insertion.sql`      | Örnek verilerin eklenmesi                     |
| `View.sql`            | Görünümler (VIEW) tanımları (varsa)           |
| `function.sql`        | Fonksiyon (FUNCTION) tanımları (varsa)        |
| `sp.sql`       | Saklı yordam (PROCEDURE) tanımları (varsa)    |
| `trigger.sql`         | Tetikleyici (TRIGGER) tanımları (varsa)       |

---

## 🧱 Kullanılan SQL Yapıları

- `CREATE TABLE`
- `INSERT INTO`
- `VIEW`
- `FUNCTION`
- `PROCEDURE`
- `TRIGGER`
- `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `IDENTITY`

---

## ⚙️ Kurulum ve Kullanım

1. SQL Server Management Studio veya benzeri bir SQL ortamı açılır.
2. `creation(3).sql` dosyası sırasıyla çalıştırılarak tüm tablo yapıları oluşturulur.
3. `insertion.sql` dosyası çalıştırılarak örnek veriler veritabanına eklenir.
4. (Varsa) `View.sql`, `function.sql`, `sp.sql` ve `trigger.sql` dosyaları sırasıyla çalıştırılır.

---

## 🏛️ Proje Tanımı

Veritabanı, çok sayıda müzenin merkezi bir sistem üzerinden yönetilmesini sağlar. Her müze kendi salonlarına, eserlerine, etkinliklerine ve personeline sahiptir. Eserler; keşifler, sanatçılar, dönemler, uygarlıklar, yapılış teknikleri gibi bilgilerle ilişkilendirilmiştir. Ayrıca transfer kayıtları, bilet işlemleri ve ziyaretçi grupları gibi detaylı alt yapılar da bulunmaktadır.

