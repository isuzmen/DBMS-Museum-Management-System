IF OBJECT_ID('sp_EserTransferi', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE dbo.sp_EserTransferi;
END
GO

-- Bu prosed�r, bir eserin yeni bir m�zeye transfer i�lemini ger�ekle�tirir. Salon tablosundaki m�ze bilgisi g�ncellenir ve transfer kayd� olu�turulur.
CREATE PROCEDURE sp_EserTransferi
    @EserID INT,
    @YeniMuzeID INT,
    @GelisTarihi DATETIME,
    @GidisTarihi DATETIME
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Salon
        SET MuzeID = @YeniMuzeID
        WHERE SalonNo = (SELECT SalonNo FROM Eserler WHERE EserID = @EserID);

        INSERT INTO TransferKaydi (GelisTarihi, GidisTarihi, MuzeID, GelisMuzeID, GidisMuzeID, EtkinlikID, CesitID, EserID, PersonelID)
        VALUES (
            @GelisTarihi,
            @GidisTarihi,
            @YeniMuzeID,
            (SELECT MuzeID FROM Salon WHERE SalonNo = (SELECT SalonNo FROM Eserler WHERE EserID = @EserID)),
            @YeniMuzeID,
            NULL, -- EtkinlikID NULL
            1,    -- CesitID 1
            @EserID,
            1     -- PersonelID 1
        );
        COMMIT TRANSACTION;

        PRINT 'Eser transferi ba�ar�yla tamamland�.';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        PRINT 'Eser transferi s�ras�nda bir hata olu�tu: ' + ERROR_MESSAGE();
    END CATCH
END
GO

EXEC sp_EserTransferi 
    @EserID = 1,
    @YeniMuzeID = 2,
    @GelisTarihi = '2024-11-29',
    @GidisTarihi = '2024-11-28';
