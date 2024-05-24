CREATE schema lab_4;

USE lab_4;

CREATE TABLE Inventory (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    item_name VARCHAR(255),
    available_quantity INT
);