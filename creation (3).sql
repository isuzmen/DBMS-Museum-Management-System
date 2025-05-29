--create DataBase MuzeYonetimi

use MuzeYonetimi



create table TransferCesitleri
(
CesitID int primary key not null,
CesitAdi varchar(50) not null,
)

create table Muze
(
MuzeID int primary key not null,
MuzeninAdi varchar(50) not null,
MuzeninAdresi varchar(100) not null,
AcilisSaati time not null,
KapanisSaati time not null,
)

create table Grup
(
GrupID int primary key not null,
GrupAdi varchar (50) not null,
MuzeID int foreign key references Muze(MuzeID) not null
)

create table Ziyaretciler
(
TCNO varchar(11) primary key not null,
Adi varchar(50),
Soyadi varchar(50),
GrupID int foreign key references Grup(GrupID),

)

create table Etkinlik
(
EtkinlikID int primary key not null,
EtkinlikAdi varchar(50) not null,
BaslangicTarihi date not null ,
BitisTarihi date not null,
MuzeID int foreign key references Muze (MuzeID) not null
)

create table Salon
(
SalonNo int primary key not null,
SalonunAdi varchar(50) not null,
MuzeID int foreign key references Muze (MuzeID) not null
)

create table BiletTuru
(
BiletTuruID int primary key not null,
Adi varchar(50) not null,
Fiyat money not null
)

create table Personel 
(
PersonelID int primary key not null,
Adi varchar (50) not null,
Soyadi varchar (50) not null
)

create table Bilet
(
BiletID int primary key not null,
Tarih datetime not null,
TCNO varchar(11) foreign key references Ziyaretciler (TCNO) not null,
BiletTuruID int foreign key references BiletTuru (BiletTuruID) not null,
MuzeID int foreign key references Muze(MuzeID) not null,
PersonelID int foreign key references Personel(PersonelID) not null
)

create table Bolge(
BolgeID int primary key not null, 
BolgeninAdi varchar(50) not null
)

create table GelisSekli(
GelisID int primary key not null, 
GelisSekliAdi varchar(50) not null
)

create table Metaryel(
MetaryelID int primary key not null, 
MetaryelAdi varchar(50) not null
)

create table Sanatci
(SanatciID int primary key not null, 
SanatciAdi varchar(50), 
SanatciSoyadi varchar(50), 
SanatcininDogumTarihi varchar(50), 
SanatcininOlumTarihi varchar(50))

create table Uygarlik
(UygarlikID int primary key not null, 
UygarliginAdi varchar(50) not null, 
UygarliginBaslangicYili varchar(50), 
UygarliginBitisYili varchar(50))

create table Donem(
DonemID int primary key not null, 
DonemAdi varchar(50) not null
)

create table YapilisTeknigi(
TeknigiID int primary key not null, 
YapilisTeknigiAdi varchar(50) 
)

create table EserinTuru(
EserTuruID int primary key not null, 
EserTuruAdi varchar(50) not null
)

create table Ulke(
UlkeninID int primary key not null, 
UlkeninAdi varchar(50) not null
)

create table Kasif(
KasifID int primary key not null, 
KasifinAdi varchar(50), 
KasifinSoyadi varchar(50), 
KasifinDogumYili varchar(50), 
KasifinOlumYili varchar(50)
)

create table Kesif(
KesifID int primary key not null, 
KesifinAdi varchar(50) not null, 
KesifTarihi varchar(50), 
UlkeninID int foreign key references Ulke(UlkeninID), 
KasifID int foreign key references Kasif(KasifID), 
BolgeID int foreign key references Bolge(BolgeID)
)

create table Eserler(
EserID int primary key not null, 
EserAdi varchar(50) not null, 
EserinYili varchar(50), 
EserinAciklamasi varchar(1000) not null, 
EserinAgirligi varchar(10), 
EserinBoyu varchar(50), 
EserinEni varchar(50), 
KesifID int foreign key references Kesif(KesifID) not null,
EserTuruID int foreign key references EserinTuru(EserTuruID) not null, 
TeknigiID int foreign key references YapilisTeknigi(TeknigiID) not null, 
DonemID int foreign key references Donem(DonemID) not null, 
UygarlikID int foreign key references Uygarlik(UygarlikID) not null, 
SanatciID int foreign key references Sanatci(SanatciID) not null, 
MetaryelID int foreign key references Metaryel(MetaryelID) not null, 
GelisID int foreign key references GelisSekli(GelisID) not null, 
SalonNo int foreign key references Salon(SalonNo) not null
)

create table TransferKaydi(
KayitID int IDENTITY(1,1) primary key, 
GelisTarihi datetime,
GidisTarihi datetime not null,
MuzeID int foreign key references Muze(MuzeID) not null,
GelisMuzeID int foreign key references Muze(MuzeID) not null, 
GidisMuzeID int foreign key references Muze(MuzeID) not null,
EtkinlikID int foreign key references Etkinlik(EtkinlikID), 
CesitID int foreign key references TransferCesitleri(CesitID) not null, 
EserID int foreign key references Eserler(EserID) not null,
PersonelID int foreign key references Personel(PersonelID) not null
)


create table TCMuze
(
TCMuzeID int primary key not null,
CesitID int foreign key references TransferCesitleri(CesitID) not null,
MuzeID int foreign key references Muze(MuzeID)not null,
CONSTRAINT CesitMuzee UNIQUE(CesitID, MuzeID)
)
create table TCEser
(
TCEserID int primary key not null,
CesitID int foreign key references TransferCesitleri(CesitID) not null,
EserID int foreign key references Eserler(EserID) not null,
CONSTRAINT CesitEser UNIQUE(CesitID, EserID) 
)

create table EserEtkinlik
(
EserEtID int primary key not null,
EtkinlikID int foreign key references Etkinlik(EtkinlikID)not null,
EserID int foreign key references Eserler(EserID) not null,
CONSTRAINT EtkinlikEser UNIQUE(EtkinlikID, EserID)
)

create table SalonEtkinlik
(
SalonEtkinlikID int primary key not null,
SalonNo int foreign key references Salon(SalonNo) not null,
EtkinlikID int foreign key references Etkinlik(EtkinlikID)not null,
CONSTRAINT EtkinlikSalon UNIQUE(SalonNo, EtkinlikID)
)

create table GrupPersonel
(
GPID int primary key not null,
GrupID int foreign key references Grup(GrupID)not null,
PersonelID int foreign key references Personel(PersonelID)not null,
CONSTRAINT CesitMuze UNIQUE(GrupID, PersonelID)
)

create table PersonelMuze
(
PMID int primary key not null,
GirisTarihi date not null,
CikisTarihi date null,
PersonelID int foreign key references Personel(PersonelID) not null,
MuzeID int foreign key references Muze(MuzeID) not null
)











