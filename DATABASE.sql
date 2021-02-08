DROP DATABASE IF EXISTS ShopDB;
CREATE SCHEMA ShopDB;

use ShopDB;

CREATE TABLE Customer(
id INT PRIMARY KEY AUTO_INCREMENT,
first_name VARCHAR(100),
last_name VARCHAR(100),
street_address VARCHAR(100),
ssn VARCHAR(100),
zip INT,
city VARCHAR(100),
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
lastUpdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

CREATE TABLE Invoice(
id INT PRIMARY KEY AUTO_INCREMENT,
customerid INT,
to_street VARCHAR(100),
to_zip INT,
to_city VARCHAR(100),
date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE  TABLE ShoeInvoice(
id INT PRIMARY KEY AUTO_INCREMENT,
invoiceid INT,
shoeid INT,
created timestamp DEFAULT CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Shoe(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100),
size INT,
color VARCHAR(100),
price INT,
brandid INT,
created timestamp DEFAULT CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE ShoeCategory(
id INT PRIMARY KEY AUTO_INCREMENT,
shoeid INT,
categoryid INT,
created timestamp DEFAULT CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE Category(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100),
created timestamp DEFAULT CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Brand(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100),
created timestamp DEFAULT CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Feedback(
id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
comment VARCHAR(100),
customerid INT,
shoeid INT,
gradeid INT,
created timestamp DEFAULT CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE Grade(
id INT PRIMARY KEY AUTO_INCREMENT,
rating VARCHAR(50),
created timestamp DEFAULT CURRENT_TIMESTAMP,
lastUpdate timestamp default CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
 

-- UNIQUE,NOT NULL
-- ON DELETE, NO ACTION, CASCADE, SET NULL, SET DEFAULT
ALTER TABLE Invoice ADD FOREIGN KEY (customerid) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE ShoeInvoice ADD FOREIGN KEY (invoiceid) REFERENCES invoice(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ShoeInvoice ADD FOREIGN KEY (shoeid) REFERENCES shoe(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ShoeCategory ADD FOREIGN KEY (shoeid) REFERENCES shoe(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE ShoeCategory ADD FOREIGN KEY (categoryid) REFERENCES category(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Shoe ADD FOREIGN KEY (brandid) REFERENCES brand(id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE Feedback ADD FOREIGN KEY (customerid) REFERENCES customer(id) ON UPDATE CASCADE ON DELETE SET NULL;
ALTER TABLE Feedback ADD FOREIGN KEY (shoeid) REFERENCES shoe(id) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE Feedback ADD FOREIGN KEY (gradeid) REFERENCES grade(id)ON UPDATE CASCADE ON DELETE SET NULL;


INSERT INTO Customer(first_name,last_name,street_address,ssn,zip,city) VALUES 
('Loutitia','Middas','0 Ohio Center','542-08-2257',03,'Santo Niño'),
('Kent','Killimister','843 Summer Ridge Point','593-43-2196',51,'Potulando'),
('Georgie','Corringham','9 Mosinee Terrace','436-72-9353',98777,'Krasnystaw'),
('Baillie','Sinisbury','741 Lerdahl Way','452-15-0660',364,'Uddevalla'),
('Mirabel','Mintoft','08263 Colorado Lane','505-79-8537',08392,'Otaslavice'),
('Brewer','Pavlovsky','11 Nelson Trail','547-29-2776',26105,'Ciwidara'),
('Rickie','Flukes','459 Schiller Center','435-14-5511',870,'Vilarelho'),
('Yehudi','Le Merchant','1462 Fair Oaks Pass','566-44-3475',12,'Gembu'),
('Agnese','Dahler','99 Bay Point','203-18-8164',98,'Salingogan'),
('Clara','Ellingsworth','90076 Union Plaza','291-91-9698',1,'Jianshan');



INSERT INTO Brand(name) VALUES 
('Nike'),
('Adidas'),
('Crocs'),
('Converse'),
('Vans'),
('Balenciaga'),
('Gucci');

INSERT INTO Category(name) VALUES ('Sneakers'),
('Loafers'),
('Running Shoes'),
('Dress shoes'),
('Boots'),
('Sandals');


INSERT INTO Shoe(name,size,color,price,brandid) VALUES 
('Nike AF 1', 45,'Purple', 1500,1),
('Adidas Runfalcon',40,'Orange', 1100,2),
('Classic Clog', 37,'Yellow', 450,3),
('Chuck 70', 43,'Red', 800,4),
('Old Skool Shoes', 40,'Blue', 749,5),
('NMD R1', 47,'Pink', 1400,2),
('Triple S', 41,'Green', 9200,6),
('Ace Sneaker', 35,'Purple', 6000,7),
('Nike AF 1', 45,'Red', 1500,1);

INSERT INTO ShoeCategory(shoeid,categoryid) VALUES 
(1, 1), 
(2, 3),
(3, 6),
(4, 4),
(5, 1),
(6, 3),
(7, 5),
(8, 4);

INSERT INTO Invoice(customerid,to_street,to_zip,to_city,date) VALUES 
(1,'0 Ohio Center',03,'Santo Niño','2021-2-1 15:03:01'), 
(1,'0 Ohio Center',03,'Santo Niño','2021-2-1 20:20:15'),
(1,'0 Ohio Center',03,'Santo Niño','2021-1-15 17:00:01'),
(2,'9 Mosinee Terrace',98777,'Krasnystaw','2021-2-3 17:13:41'),
(2,'9 Mosinee Terrace',98777,'Krasnystaw','2021-2-10 12:00:01'),
(2,'9 Mosinee Terrace',98777,'Krasnystaw','2021-2-4 11:11:11'),
(10,'90076 Union Plaza',1,'Jianshan','2020-10-10 22:10:03'),
(9,'99 Bay Point',98,'Salingogan','2020-12-30 00:00:01'),
(8,'459 Schiller Center',870,'Vilarelho','2018-08-13 13:10:15');

INSERT INTO ShoeInvoice(invoiceid,shoeid) VALUES
(1,1), 
(1,1), 
(2,3), 
(3,4),
(4,5), 
(5,8), 
(6,2), 
(7,1),
(8,3),
(9,3);

INSERT INTO Grade(rating) VALUES
('Mycket nöjd'),
('Nöjd'),
('Ganska Nöjd'),
('Missnöjd');

INSERT INTO Feedback(customerid, shoeid, gradeid, comment) VALUES
(1,1,1,'Gillar verkligen denna produkt'),
(1,2,1,'Mycket bra köp'),
(5,1,3,'Funkar men kunde vara bättre'),
(4,1,3,'Sämst');

CREATE INDEX IX_shoename on shoe(name);
SELECT * FROM customer;
SELECT * FROM invoice;
SELECT * FROM shoeinvoice;
SELECT * FROM shoe;
SELECT * FROM category;
SELECT * FROM Brand;
SELECT * FROM shoecategory;
SELECT * FROM feedback;
SELECT * FROM grade;