CREATE TABLE IF NOT EXISTS CustomerDetail (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    MailAddress VARCHAR(200) NOT NULL,
    PermanentAddress VARCHAR(200) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS AccountDetail (
    AccNumber INT PRIMARY KEY AUTO_INCREMENT,
    AccBalance DECIMAL(15, 2) NOT NULL,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES CustomerDetail(CustomerID)
);

CREATE TABLE IF NOT EXISTS TransferDetail (
    TransferID INT PRIMARY KEY AUTO_INCREMENT,
    DateOfTransfer DATE NOT NULL,
    RecipientName VARCHAR(100) NOT NULL,
    Status VARCHAR(20),
    AccNumber INT NOT NULL,
    FOREIGN KEY (AccNumber) REFERENCES AccountDetail(AccNumber)
);




