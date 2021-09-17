CREATE TABLE Department(
	departmentId SERIAL,
	name VARCHAR(20),
	PRIMARY KEY (departmentId)
)

INSERT INTO Department(name) VALUES ('Cartera');
INSERT INTO Department(name) VALUES ('Tecnología');
INSERT INTO Department(name) VALUES ('Operaciones');
INSERT INTO Department(name) VALUES ('SAC');
INSERT INTO Department(name) VALUES ('Contabilidad');

CREATE TABLE Country(
	countryId SERIAL,
	name VARCHAR(20),
	PRIMARY KEY (countryId)
);

INSERT INTO Country (name) VALUES ('Colombia');
INSERT INTO Country (name) VALUES ('Reino Unido');
INSERT INTO Country (name) VALUES ('Alemania');
INSERT INTO Country (name) VALUES ('Nueva Zelanda');
INSERT INTO Country (name) VALUES ('Francia');

CREATE TABLE Position(
	positionId SERIAL,
	name VARCHAR(20),
	PRIMARY KEY (positionId)
);

INSERT INTO Position (name) VALUES ('Gerente');
INSERT INTO Position (name) VALUES ('Contador');
INSERT INTO Position (name) VALUES ('Vendedor');
INSERT INTO Position (name) VALUES ('Asistente');
INSERT INTO Position (name) VALUES ('Coordinador');

CREATE TABLE City(
	cityId SERIAL,
	name VARCHAR(20),
	countryId INT,
	PRIMARY KEY (cityId),
	FOREIGN KEY (countryId) REFERENCES country(countryId)
);

INSERT INTO City(name,countryId) VALUES ('Bogotá',1);
INSERT INTO City(name,countryId) VALUES ('York',2);
INSERT INTO City(name,countryId) VALUES ('Munich',3);
INSERT INTO City(name,countryId) VALUES ('Wellington',4);
INSERT INTO City(name,countryId) VALUES ('París',5);

CREATE TABLE Address(
	addressId SERIAL,
	line1 VARCHAR(30),
	line2 VARCHAR(30),
	cityId INT,
	PRIMARY KEY (addressId),
	FOREIGN KEY (cityId) REFERENCES City(cityId)
);

INSERT INTO Address(line1,line2,cityId) VALUES ('Calle 15 # 12 50','Apto 502',1);
INSERT INTO Address(line1,line2,cityId) VALUES ('Johns Street 4-30','59200',2);
INSERT INTO Address(line1,line2,cityId) VALUES ('Am bavariaPark','80339 Munchen',3);
INSERT INTO Address(line1,line2,cityId) VALUES ('Corner of Tory Street','Wellington 6011',4);
INSERT INTO Address(line1,line2,cityId) VALUES ('2 Rue d orsel ','75018 Paris',5);

CREATE TABLE BranchOffice(
	branchId SERIAL,
	name VARCHAR(20),
	addressId INT,
	PRIMARY KEY (branchId),
	FOREIGN KEY (addressId) REFERENCES Address(addressId)
);

INSERT INTO BranchOffice (name,addressId) VALUES ('Starbucks',2);
INSERT INTO BranchOffice (name,addressId) VALUES ('Tostao',1);
INSERT INTO BranchOffice (name,addressId) VALUES ('Subway',4);
INSERT INTO BranchOffice (name,addressId) VALUES ('Guitar Center',3);
INSERT INTO BranchOffice (name,addressId) VALUES ('US',5);


CREATE TABLE Employee(
	employeeId INT,
	fullName VARCHAR(50),
	branchId INT,
	departmentId INT,
	positionId INT,
	addressId INT,
	supervisorId INT,
	PRIMARY KEY (employeeId),
	FOREIGN KEY (branchId) REFERENCES BranchOffice(branchId),
	FOREIGN KEY (departmentId) REFERENCES Department(departmentId),
	FOREIGN KEY (positionId) REFERENCES Position(positionId),
	FOREIGN KEY (addressId) REFERENCES address(addressId),
	FOREIGN KEY (supervisorId) REFERENCES Address(addressId)
);

INSERT INTO Employee (employeeId,fullName,branchId,departmentId,positionId,addressId,supervisorId)
VALUES (5748,'Juan Rodriguez',2,4,5,3,3);

INSERT INTO Employee (employeeId,fullName,branchId,departmentId,positionId,addressId,supervisorId)
VALUES (4520,'John Doe',3,2,1,2,2);

INSERT INTO Employee (employeeId,fullName,branchId,departmentId,positionId,addressId,supervisorId)
VALUES (49583,'Matt Bellamy',1,1,4,2,5);

INSERT INTO Employee (employeeId,fullName,branchId,departmentId,positionId,addressId,supervisorId)
VALUES (205862,'Richard Stanley',3,2,1,1,1);

INSERT INTO Employee (employeeId,fullName,branchId,departmentId,positionId,addressId,supervisorId)
VALUES (384525,'Mary Patt',4,2,3,2,5);

CREATE TABLE EmployeeAudit(
	employeeId INT,
	fullName VARCHAR(50),
	branchOffice VARCHAR(20),
	department VARCHAR(20),
	position VARCHAR(20),
	address VARCHAR(70),
	city VARCHAR(20),
	country VARCHAR(20),
	event VARCHAR(10),
	registeredAt DATE
);

