/*////////////////////////////////////////////////////////////////////////////*/
/*  Pat Looft   CIS 4331-001    Assignment 03   04/30/2019                    */
/*////////////////////////////////////////////////////////////////////////////*/

CREATE TABLE equipment
(
	SerialNo NUMBER PRIMARY KEY,
	LastInspectionDate DATE NOT NULL,
	DateMade DATE
);

CREATE TABLE equipmentDetail
(
	EquipmentDetailID NUMBER PRIMARY KEY,
	Make VARCHAR2(16) NOT NULL,
	Model VARCHAR2(40) NOT NULL,
	Type VARCHAR2(16) NOT NULL,
	SerialNo NUMBER REFERENCES equipment (SerialNo)
);

CREATE TABLE customer
(
	CustID NUMBER PRIMARY KEY,
	CustName VARCHAR2(16) NOT NULL,
	CustCategory VARCHAR2(16) NOT NULL
);

CREATE TABLE SalesRep
(
	SalesRepID NUMBER PRIMARY KEY,
	Rank VARCHAR2(16) NOT NULL,
	SRepFName VARCHAR2(10) NOT NULL,
	SRepLName VARCHAR2(10) NOT NULL,
	Protege VARCHAR2(10)
);

CREATE TABLE sale
(
	SaleTransID NUMBER PRIMARY KEY,
	Price NUMBER NOT NULL,
	DateOfSale DATE NOT NULL,
	SalesRepID NUMBER REFERENCES SalesRep (SalesRepID),
	CustID NUMBER REFERENCES customer (CustID),
	SerialNo NUMBER REFERENCES equipment (SerialNo)
);

CREATE TABLE Rental
(
	RentTansID NUMBER PRIMARY KEY,
	Price NUMBER NOT NULL,
	DateOfRental DATE NOT NULL,
	SerialNo NUMBER REFERENCES equipment (SerialNo),
	SalesRepID NUMBER REFERENCES SalesRep (SalesRepID),
	CustID NUMBER REFERENCES customer (CustID)
);




/*
DROP TABLE Rental;
DROP TABLE sale;
DROP TABLE SalesRep;
DROP TABLE customer;
DROP TABLE equipmentDetail;
DROP TABLE equipment;
*/

/*////////////////////////////////////////////////////////////////////////////*/

/*////////////////////////////////////////////////////////////////////////////*/

/*////////////////////////////////////////////////////////////////////////////*/

INSERT INTO equipment
VALUES (3109801, SYSDATE, SYSDATE);

INSERT INTO equipment
VALUES (3109835, SYSDATE, SYSDATE);

INSERT INTO equipmentDetail
VALUES (3109801, 'United Rentals', 'Articulating Boom Lift, 125, 4WD', 'Boom lift', 3109801);

INSERT INTO equipmentDetail
VALUES (3109835, 'United Rentals', 'Articulating Boom Lift, 135, 4WD', 'Boom lift', 3109835);

INSERT INTO customer
VALUES (1, 'Will', 'Group 1');

INSERT INTO customer 
VALUES (2, 'Anh', 'Group 1');

INSERT INTO SalesRep
VALUES (1, 'clerk', 'Shannon', 'Hoon', 'Great one');

INSERT INTO SalesRep
VALUES (2, 'Manager', 'The', 'Great One', 'Great one');

INSERT INTO sale
VALUES (1, 3.50, SYSDATE, 1, 1, 3109801);

INSERT INTO sale
VALUES (2, 4.50, SYSDATE, 1, 2, 3109835);

INSERT INTO rental
VALUES (1, 2.00, SYSDATE, 3109801, 1, 2);

INSERT INTO rental
VALUES (2, 3.00, SYSDATE, 3109835, 2, 1);