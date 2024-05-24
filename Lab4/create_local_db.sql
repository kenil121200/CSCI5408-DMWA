CREATE SCHEMA lab_4;
USE lab_4;

CREATE TABLE  Customers(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255)
);

CREATE TABLE Order_info (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    item_name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Customers(id)
);

INSERT INTO `Customers` (`name`,`email`,`phone`,`address`)
VALUES
  ("Aristotle Witt","aristotlewitt@outlook.com","5355657943","4554 Nunc Road, D8G 2G9, Newfoundland and Labrador"),
  ("Delilah Ballard","delilahballard861@outlook.com","8109241788","Ap #294-3709 Ut Avenue, 40G 8E3, Nunavut"),
  ("Cecilia Byers","ceciliabyers7274@outlook.com","4686708963","Ap #778-5728 Nibh. Rd., M7M 2W0, New Brunswick"),
  ("Eleanor Chapman","eleanorchapman@yahoo.com","6044833636","8624 Interdum. Street, M8R 7S6, Quebec"),
  ("Perry Clark","perryclark@yahoo.com","9885082245","Ap #484-3782 Sagittis Street, H1E 7A2, New Brunswick");
