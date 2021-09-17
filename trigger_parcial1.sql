--Función que se dispara al ejecutar el trigger y almacena información en la tabla EmployeeAudit
CREATE OR REPLACE FUNCTION listenEvent()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
$$
DECLARE
	branchN varchar;
	departmentN varchar;
	positionN varchar;
	addressN  varchar;
	cityN  varchar;
	countryN varchar;
	currentDate  date;
	
	newBranch varchar;
	newDepartment varchar;
	newPosition varchar;
	newAddress  varchar;
	newCity  varchar;
	newCountry varchar;
BEGIN
	 SELECT Department.name, CONCAT(Address.line1,'-',Address.line2),
	 branch.name,Position.name,City.name,Country.name INTO departmentN,addressN,branchN,positionN,cityN,countryN  
	 FROM Employee INNER JOIN Department ON Department.departmentId = Employee.departmentId
	 INNER JOIN Address ON Address.addressid = Employee.addressId
	 INNER JOIN Position ON Position.positionId = Employee.positionId
	 INNER JOIN BranchOffice AS branch ON branch.branchid = Employee.branchId
	 INNER JOIN City ON City.cityId = Address.cityId
	 INNER JOIN Country ON Country.countryId = City.countryId
	 WHERE OLD.employeeId = Employee.employeeId;
	 
	 SELECT Department.name, CONCAT(Address.line1,'-',Address.line2),
	 branch.name,Position.name,City.name,Country.name INTO newDepartment,newAddress,newBranch,newPosition,
	 newCity,newCountry  
	 FROM Employee INNER JOIN Department ON Department.departmentId = Employee.departmentId
	 INNER JOIN Address ON Address.addressid = Employee.addressId
	 INNER JOIN Position ON Position.positionId = Employee.positionId
	 INNER JOIN BranchOffice AS branch ON branch.branchid = Employee.branchId
	 INNER JOIN City ON City.cityId = Address.cityId
	 INNER JOIN Country ON Country.countryId = City.countryId
	 WHERE NEW.employeeId = Employee.employeeId;
	 
	 
	IF (TG_OP = 'DELETE') THEN
            INSERT INTO EmployeeAudit VALUES(OLD.employeeId, OLD.fullName, branchN, departmentN, positionN, addressN,cityN, countryN,'DELETE',NOW());
            RETURN OLD;
	
	ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO EmployeeAudit VALUES(OLD.employeeId, OLD.fullName, branchN, departmentN, positionN, addressN,cityN, countryN,'UPDATE',NOW());
            RETURN NEW;
    ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO EmployeeAudit VALUES(
				NEW.employeeid, 
				NEW.fullname, newBranch, newDepartment, newPosition, newAddress, newCity,newCountry,
				'INSERT', 
				NOW());
            RETURN NEW;
	
    END IF;
END;
$$;

--Elimina el trigger si en dado caso llegase a existir
DROP TRIGGER IF EXISTS recibirPeticion ON employee;

--Creación del trigger
CREATE TRIGGER recibirPeticion
	AFTER DELETE OR UPDATE OR INSERT
	ON employee
	FOR EACH ROW
	EXECUTE PROCEDURE listenEvent();

--Ejemplo de funcionamiento
UPDATE employee SET fullName = 'Fransisco' WHERE employeeId = 5748;
SELECT * FROM EmployeeAudit;
	