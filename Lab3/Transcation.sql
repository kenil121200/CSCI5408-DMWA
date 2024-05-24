SET @status = 'accept';
SET @debitAmount = 500;
SET @accountid = 2;


CALL Transfer(@debitAmount, @accountid, @status);


