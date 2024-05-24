DELIMITER //

CREATE PROCEDURE Transfer(IN debitAmount INT, IN accountid INT, IN status VARCHAR(20))
BEGIN
    START TRANSACTION;
	
    SAVEPOINT IntialSavepoint;
    
    UPDATE AccountDetail
    SET AccBalance = AccBalance - debitAmount
    WHERE AccNumber = accountid;

    INSERT INTO TransferDetail (AccNumber, DateOfTransfer, RecipientName, Status)
    VALUES (accountid, CURDATE(), 'Manish', 'waiting');

    IF status = 'accept' THEN
        UPDATE TransferDetail
        SET Status = 'accept' 
        WHERE AccNumber = accountid;
        COMMIT;
    ELSEIF status = 'decline' THEN
        ROLLBACK TO SAVEPOINT IntialSavepoint;
    END IF;
END //

DELIMITER ;
