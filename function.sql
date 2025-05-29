IF OBJECT_ID('ZiyaretciSayisiByTarih', 'FN') IS NOT NULL
BEGIN 
    DROP FUNCTION ZiyaretciSayisiByTarih;
END 
GO

-- Verilen tarih aralýðýnda etkinliklere katýlan farklý ziyaretçi sayýsýný hesaplayan fonksiyon
CREATE FUNCTION ZiyaretciSayisiByTarih (@Tarih DATE)
RETURNS INT
AS
BEGIN
    DECLARE @ZiyaretciSayisi INT;

    SELECT 
       @ZiyaretciSayisi = COUNT(DISTINCT Z.TCNO)
    FROM Ziyaretciler Z
    INNER JOIN Grup G ON Z.GrupID = G.GrupID
    INNER JOIN Etkinlik E ON G.MuzeID = E.MuzeID
    WHERE @Tarih BETWEEN E.BaslangicTarihi AND E.BitisTarihi;

    RETURN @ZiyaretciSayisi;
END;
GO

SELECT dbo.ZiyaretciSayisiByTarih('2022-03-10') AS Sonuc;

