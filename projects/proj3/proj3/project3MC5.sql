/*////////////////////////////////////////////////////////////////////////////*/
/*  Pat Looft   CIS 4331-001    Assignment 03   04/30/2019                    */
/*////////////////////////////////////////////////////////////////////////////*/

/*////////////////////////////////////////////////////////////////////////////*/
/*                              BASE TABLES                                   */
/*////////////////////////////////////////////////////////////////////////////*/

CREATE TABLE software_package
(
	SPID number CONSTRAINT spPK PRIMARY KEY,
	SPName VARCHAR2(25)
	/*NoOfInstallations derived attribute*/
);

CREATE TABLE employee
(
	EmpID number CONSTRAINT Emp_pk PRIMARY KEY,
	EmpName VARCHAR2(25) CONSTRAINT EmpName_nn NOT NULL,
	EmpSkill     VARCHAR2(25)/*multivalued*/
);

CREATE TABLE computer
(
	CompID 		number 			CONSTRAINT  comp_pk PRIMARY KEY,
	CompModel 	VARCHAR2(16)	CONSTRAINT CompModel_nn NOT NULL,
	CompMake	VARCHAR2(16)	CONSTRAINT CompMake_nn NOT NULL, 
	EmpId		Number			REFERENCES employee (EmpID) NOT NULL 
);

/*
DROP TABLE software_package;
DROP TABLE employee;
DROP TABLE computer;
*/

/*////////////////////////////////////////////////////////////////////////////*/
/*                              CONNECTING TABLES                             */
/*////////////////////////////////////////////////////////////////////////////*/

Create Table installed_at
(
	CompID 	number	REFERENCES computer (CompID),
	SPID	number 	REFERENCES software_package (SPID),
	DateOfInstall DATE
);


--!DROP TABLE installed_at;

Create Table certified_to_use
(
	EmpID 	number	REFERENCES employee (EmpID),
	SPID	number 	REFERENCES software_package (SPID),
	DateInstalled	DATE NOT NULL
);

--!DROP TABLE certified_to_use;

CREATE TABLE emp_skills
(
	EmpID NUMBER REFERENCES employee (EmpID),
	EmpSkill VARCHAR2(24)
);

--!DROP TABLE emp_skills;

/*////////////////////////////////////////////////////////////////////////////*/
/*                              INSERTS                                       */
/*////////////////////////////////////////////////////////////////////////////*/

INSERT INTO software_package
VALUES (1, 'Microsoft Office');

INSERT INTO software_package
VALUES (2, 'Adobe Premiere Sweet');

INSERT INTO software_package
VALUES (3, 'Eclipse IDE');
/*////////////////////////////////////////////////////////////////////////////*/
INSERT INTO employee
VALUES (1, 'Alex', 'Sells things');

INSERT INTO employee
VALUES (2, 'Victor', 'Does not sell things');

/*////////////////////////////////////////////////////////////////////////////*/

INSERT INTO computer
VALUES (1, 'VN7-591G-70RT', 'Aspire v15', 001);

INSERT INTO computer
VALUES (2, 'E5-573G-52G3', 'Aspire E', 002);

INSERT INTO computer
VALUES (3, 'A717-72G-700J', 'Aspire 7', 001);

/*////////////////////////////////////////////////////////////////////////////*/

INSERT INTO installed_at
VALUES (1, 1, SYSDATE);

INSERT INTO installed_at
VALUES (2, 2, SYSDATE);

INSERT INTO installed_at
VALUES (3, 1, SYSDATE);

/*////////////////////////////////////////////////////////////////////////////*/

INSERT INTO certified_to_use
VALUES (1, 1, SYSDATE);

INSERT INTO certified_to_use
VALUES (1, 2, SYSDATE);

INSERT INTO certified_to_use
VALUES (2, 2, SYSDATE);