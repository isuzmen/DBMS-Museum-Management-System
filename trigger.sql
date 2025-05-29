CREATE TABLE TransferLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    EserID INT NOT NULL,
    EskiMuzeID INT NOT NULL,
    YeniMuzeID INT NOT NULL,
    TransferTarihi DATETIME NOT NULL DEFAULT GETDATE()
);

CREATE TRIGGER trg_EserTransferKontrol
ON Eserler
AFTER UPDATE
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Salon kontrol
        IF EXISTS (
            SELECT 1
            FROM INSERTED I
            WHERE NOT EXISTS (
                SELECT 1
                FROM Salon S
                WHERE S.SalonNo = I.SalonNo AND S.MuzeID = (SELECT TOP 1 MuzeID FROM TransferKaydi WHERE EserID = I.EserID ORDER BY KayitID DESC)
            )
        )
        BEGIN
            ROLLBACK TRANSACTION;
            RAISERROR ('Yeni m�zedeki salon ge�ersiz.', 16, 1);
            RETURN;
        END;

        -- Transfer Log tablosuna ekleme
        INSERT INTO TransferLog (EserID, EskiMuzeID, YeniMuzeID)
        SELECT 
            I.EserID,
            (SELECT TOP 1 GelisMuzeID FROM TransferKaydi WHERE EserID = I.EserID ORDER BY KayitID DESC),
            (SELECT TOP 1 GidisMuzeID FROM TransferKaydi WHERE EserID = I.EserID ORDER BY KayitID DESC)
        FROM INSERTED I;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Trigger �al���rken bir hata olu�tu: ' + ERROR_MESSAGE();
    END CATCH
END;

UPDATE Eserler
SET SalonNo = 2 
WHERE EserID = 1;




