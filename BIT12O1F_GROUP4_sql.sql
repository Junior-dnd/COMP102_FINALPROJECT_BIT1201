create database Market_Stall_Allocation_Db;


CREATE TABLE CouncilStaff (
    CouncilStaffID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(70) NOT NULL,
    Role VARCHAR(50) NOT NULL,
    Contact VARCHAR(30) NOT NULL
);
	
	
	
CREATE TABLE Market (
    MarketID INT AUTO_INCREMENT PRIMARY KEY,
    MarketName VARCHAR(150) NOT NULL,
    Location VARCHAR(70) NOT NULL,
    Capacity INT NOT NULL
);




CREATE TABLE Stall (
    StallID INT AUTO_INCREMENT PRIMARY KEY,
    MarketID INT NOT NULL,
    Size VARCHAR(50) NOT NULL,
    Status VARCHAR(70) NOT NULL DEFAULT 'Available',

    FOREIGN KEY (MarketID)
    REFERENCES Market(MarketID)
);





CREATE TABLE Trader (
    TraderID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(70) NOT NULL,
    Contact VARCHAR(30) NOT NULL,
    Age INT NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    RegistrationDate DATE NOT NULL,
    GoodsSold VARCHAR(100) NOT NULL
);




CREATE TABLE Buyer (
    BuyerID INT AUTO_INCREMENT PRIMARY KEY,
    Contact VARCHAR(70) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    FullName VARCHAR(70) NOT NULL,
    GoodsBought VARCHAR(150)
);





CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BuyerID INT NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentDate DATE NOT NULL,
    Method VARCHAR(30) NOT NULL,

    CONSTRAINT fk_payment_buyer
        FOREIGN KEY (BuyerID)
        REFERENCES Buyer(BuyerID)
);




CREATE TABLE Allocation (
    AllocationID INT AUTO_INCREMENT PRIMARY KEY,
    CouncilStaffID INT NOT NULL,
    TraderID INT NOT NULL,
    StallID INT NOT NULL,
    AllocationDate DATE NOT NULL,
    ExpiryDate DATE NOT NULL,

    FOREIGN KEY (CouncilStaffID)
    REFERENCES CouncilStaff(CouncilStaffID),

    FOREIGN KEY (TraderID)
    REFERENCES Trader(TraderID),

    FOREIGN KEY (StallID)
    REFERENCES Stall(StallID)
);


CREATE TABLE AllocationPayment (
    StallAllocationID INT AUTO_INCREMENT PRIMARY KEY,
    DatePaid DATE NOT NULL,
    AllocationID INT NOT NULL,
    PaymentID INT NOT NULL,

    CONSTRAINT fk_allocpayment_allocation
        FOREIGN KEY (AllocationID)
        REFERENCES Allocation(AllocationID),

    CONSTRAINT fk_allocpayment_payment
        FOREIGN KEY (PaymentID)
        REFERENCES Payment(PaymentID)
);
	
	
INSERT INTO CouncilStaff (FullName, Role, Contact)
VALUES
('John Kamara','Market Manager','076111111'),
('Fatmata Conteh','Revenue Officer','076111112'),
('Abdul Sesay','Inspector','076111113'),
('Ibrahim Koroma','Supervisor','076111114'),
('Musu Bangura','Administrator','076111115'),
('Mariama Kallon','Revenue Officer','076111116'),
('Sorie Jalloh','Inspector','076111117'),
('Joseph Turay','Supervisor','076111118'),
('Kadiatu Bah','Administrator','076111119'),
('Alusine Kamara','Manager','076111120');




INSERT INTO Market (MarketName, Location, Capacity)
VALUES
('Big Market','Freetown',500),
('Congo Market','Freetown',300),
('Kissy Market','Kissy',250),
('Bo Central Market','Bo',400),
('Kenema Market','Kenema',350);



INSERT INTO Stall (MarketID, Size, Status)
VALUES
(1,'Small','Occupied'),
(1,'Medium','Occupied'),
(1,'Large','Available'),
(2,'Small','Occupied'),
(2,'Medium','Available'),
(2,'Large','Occupied'),
(3,'Small','Occupied'),
(3,'Medium','Available'),
(3,'Large','Occupied'),
(4,'Small','Occupied'),
(4,'Medium','Occupied'),
(4,'Large','Available'),
(5,'Small','Occupied'),
(5,'Medium','Occupied'),
(5,'Large','Available');




INSERT INTO Trader
(FullName, Contact, Age, Address, Gender, RegistrationDate, GoodsSold)
VALUES
('Mohamed Bah','078000001',35,'Freetown','Male','2025-01-10','Vegetables'),
('Aminata Kamara','078000002',28,'Waterloo','Female','2025-01-11','Fish'),
('Sorie Conteh','078000003',40,'Kissy','Male','2025-01-12','Rice'),
('Mariama Bangura','078000004',31,'Bo','Female','2025-01-15','Clothes'),
('Abdul Koroma','078000005',42,'Kenema','Male','2025-01-18','Shoes'),
('Fatmata Sesay','078000006',26,'Makeni','Female','2025-01-20','Vegetables'),
('Ibrahim Kallon','078000007',38,'Bo','Male','2025-01-22','Electronics'),
('Musu Turay','078000008',29,'Kenema','Female','2025-01-25','Fish'),
('Joseph Jalloh','078000009',45,'Freetown','Male','2025-01-28','Rice'),
('Kadiatu Bah','078000010',34,'Waterloo','Female','2025-02-01','Cosmetics'),
('Sorie Kamara','078000011',30,'Bo','Male','2025-02-03','Bags'),
('Mariatu Conteh','078000012',36,'Kenema','Female','2025-02-04','Vegetables'),
('Alusine Sesay','078000013',41,'Makeni','Male','2025-02-06','Phones'),
('Hawa Bangura','078000014',27,'Kissy','Female','2025-02-08','Fish'),
('Mohamed Koroma','078000015',39,'Freetown','Male','2025-02-10','Rice');



INSERT INTO Buyer
(Contact, Address, FullName, GoodsBought)
VALUES
('079100001','Freetown','Peter Johnson','Fish'),
('079100002','Bo','Alice Kamara','Vegetables'),
('079100003','Kenema','David Conteh','Rice'),
('079100004','Makeni','Musa Koroma','Shoes'),
('079100005','Waterloo','John Bangura','Clothes'),
('079100006','Freetown','Mariama Jalloh','Fish'),
('079100007','Bo','Abdul Kallon','Phones'),
('079100008','Kenema','Fatmata Turay','Cosmetics'),
('079100009','Makeni','Ibrahim Bah','Rice'),
('079100010','Kissy','Hawa Conteh','Vegetables');




INSERT INTO Allocation
(CouncilStaffID, TraderID, StallID, AllocationDate, ExpiryDate)
VALUES
(1,1,1,'2025-01-01','2025-12-31'),
(2,2,2,'2025-01-02','2025-12-31'),
(3,3,4,'2025-01-03','2025-12-31'),
(4,4,6,'2025-01-04','2025-12-31'),
(5,5,7,'2025-01-05','2025-12-31'),
(6,6,9,'2025-01-06','2025-12-31'),
(7,7,10,'2025-01-07','2025-12-31'),
(8,8,11,'2025-01-08','2025-12-31'),
(9,9,13,'2025-01-09','2025-12-31'),
(10,10,14,'2025-01-10','2025-12-31');





INSERT INTO Payment
(BuyerID, Amount, PaymentDate, Method)
VALUES
(1,250.00,'2025-03-01','Cash'),
(2,120.00,'2025-03-02','Mobile Money'),
(3,500.00,'2025-03-03','Cash'),
(4,300.00,'2025-03-04','Bank Transfer'),
(5,450.00,'2025-03-05','Cash'),
(6,180.00,'2025-03-06','Mobile Money'),
(7,600.00,'2025-03-07','Bank Transfer'),
(8,220.00,'2025-03-08','Cash'),
(9,340.00,'2025-03-09','Mobile Money'),
(10,160.00,'2025-03-10','Cash'),
(1,275.00,'2025-03-11','Cash'),
(2,190.00,'2025-03-12','Mobile Money'),
(3,410.00,'2025-03-13','Cash'),
(4,320.00,'2025-03-14','Bank Transfer'),
(5,550.00,'2025-03-15','Cash');




INSERT INTO AllocationPayment
(DatePaid, AllocationID, PaymentID)
VALUES
('2025-03-01',1,1),
('2025-03-02',2,2),
('2025-03-03',3,3),
('2025-03-04',4,4),
('2025-03-05',5,5),
('2025-03-06',6,6),
('2025-03-07',7,7),
('2025-03-08',8,8),
('2025-03-09',9,9),
('2025-03-10',10,10);