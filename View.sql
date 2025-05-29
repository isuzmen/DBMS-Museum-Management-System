IF OBJECT_ID('dbo.Vw_ZiyaretciBilgileri', 'V') IS NOT NULL
BEGIN
    DROP VIEW dbo.Vw_ZiyaretciBilgileri;
END
GO

-- Her müzeye ait etkinliklerin durumunu, ziyaretçi sayýsýný, etkinlik tarihlerini ve katýlýmcý bilgilerini görüntüleyen View
CREATE VIEW dbo.Vw_ZiyaretciBilgileri AS
SELECT
    Z.TCNO,
    Z.Adi,
    Z.Soyadi,
    G.GrupAdi,
    M.MuzeninAdi,
    E.EtkinlikAdi,
    E.BaslangicTarihi,
    E.BitisTarihi,

    dbo.ZiyaretciSayisiByTarih(E.BaslangicTarihi) AS ZiyaretciSayisi,

    CASE 
        WHEN GETDATE() < E.BaslangicTarihi THEN 'Yaklaþan Etkinlik'
        WHEN GETDATE() BETWEEN E.BaslangicTarihi AND E.BitisTarihi THEN 'Devam Ediyor'
        ELSE 'Geçmiþ Etkinlik'
    END AS EtkinlikDurumu,

    FORMAT(E.BaslangicTarihi, 'yyyy-MM-dd') AS BaslangicTarihiFormatted,
    FORMAT(E.BitisTarihi, 'yyyy-MM-dd') AS BitisTarihiFormatted
FROM
    Ziyaretciler Z
    INNER JOIN Grup G ON Z.GrupID = G.GrupID
    INNER JOIN Muze M ON G.MuzeID = M.MuzeID
    INNER JOIN Etkinlik E ON M.MuzeID = E.MuzeID
GO

SELECT
    Z.TCNO,
    Z.Adi,
    Z.Soyadi,
    G.GrupAdi,
    M.MuzeninAdi,
    E.EtkinlikAdi,
    V.EtkinlikDurumu,
    V.ZiyaretciSayisi,
    V.BaslangicTarihiFormatted,
    V.BitisTarihiFormatted
FROM 
    dbo.Vw_ZiyaretciBilgileri V
INNER JOIN
    Ziyaretciler Z ON V.TCNO = Z.TCNO
INNER JOIN
    Grup G ON Z.GrupID = G.GrupID
INNER JOIN
    Muze M ON G.MuzeID = M.MuzeID
INNER JOIN
    Etkinlik E ON M.MuzeID = E.MuzeID
WHERE
    V.ZiyaretciSayisi > 0  
ORDER BY
    V.MuzeninAdi, V.BaslangicTarihiFormatted;
